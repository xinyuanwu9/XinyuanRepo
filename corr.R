corr <- function(directory, threshold = 0){
	files <- list.files(directory, full.names = TRUE)
	result <- numeric()
	for (i in 1:332){
		csv <- read.csv(files[i])
		if (sum(complete.cases(csv)) >= threshold) {
			data <- csv[complete.cases(csv), ]
			calculate <- cor(data$sulfate, data$nitrate)
			result <- c(result, calculate)
		}
	}
	result
}