Raw <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE)
Raw_Sub <- Raw[Raw$Date %in% c("1/2/2007", "2/2/2007"), ]
Date_Time <- strptime(paste(Raw_Sub$Date, Raw_Sub$Time), format = "%d/%m/%Y %H:%M:%S")
data <- data.frame(Date_Time, Raw_Sub[, c(-1, -2)])
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
png(file = "Plot1.png")
with(data, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red"))
dev.off()