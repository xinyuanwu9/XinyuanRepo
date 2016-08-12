data <- read.csv("activity.csv")
data$date <- as.Date(data$date, format = "%Y-%m-%d")


day_steps <- sapply(split(data$steps, data$date), sum)
hist(day_steps, xlab = "Total Number of Steps Taken Each Day", col = "red", main = "Total Number of Steps Taken Each Day", breaks = 61)
day_steps_mean <- mean(day_steps, na.rm = TRUE)
day_steps_median <- median(day_steps, na.rm = TRUE)


int_steps_mean <- sapply(split(data$steps, data$interval), mean, na.rm = TRUE)
plot(unique(data$interval), int_steps_mean, type = "l", xlab = "Interval", ylab = "Average Number of Steps", main = "Average Number of Steps Each Interval")
max_steps_interval <- names(int_steps_mean[int_steps_mean == max(int_steps_mean)])


sum_NA <- sum(is.na(data$steps))
data_original <- data.frame(data)
for (i in 1:nrow(data)){
	if (is.na(data[i, 1]) == TRUE) {
		data[i, 1] <- int_steps_mean[names(int_steps_mean) == as.character(data[i, 3])]
	}
}
day_steps_fillNA <- sapply(split(data$steps, data$date), sum)
hist(day_steps_fillNA, xlab = "Total Number of Steps Taken Each Day", col = "red", main = "Total Number of Steps Taken Each Day, NA filled", breaks = 61)
day_steps_mean_fillNA <- mean(day_steps_fillNA)
day_steps_median_fillNA <- median(day_steps_fillNA)


type_of_day <- function(x){
	if (x %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")){
		return("Weekday")}
	else {
		return("Weekend")}
}
day_col <- sapply(weekdays(data[, 2]), type_of_day)
data <- data.frame(data, day_col)
weekday_data <- split(data, data$day_col)$Weekday
weekend_data <- split(data, data$day_col)$Weekend
int_steps_mean_weekday <- sapply(split(weekday_data$steps, weekday_data$interval), mean)
int_steps_mean_weekend <- sapply(split(weekend_data$steps, weekend_data$interval), mean)
weekday_table <- data.frame(int_steps_mean_weekday, unique(data$interval), "Weekday")
names(weekday_table) <- c("Stepsmean", "Interval", "day")
weekend_table <- data.frame(int_steps_mean_weekend, unique(data$interval), "Weekend")
names(weekend_table) <- c("Stepsmean", "Interval", "day")
new_table <- rbind(weekday_table, weekend_table)
xyplot(Stepsmean ~ Interval | day, data = new_table, layout = c(1, 2), type = "l", ylab = "Mean of Steps")
