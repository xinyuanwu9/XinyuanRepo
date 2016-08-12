Raw <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE)
Raw_Sub <- Raw[Raw$Date %in% c("1/2/2007", "2/2/2007"), ]
Date_Time <- strptime(paste(Raw_Sub$Date, Raw_Sub$Time), format = "%d/%m/%Y %H:%M:%S")
data <- data.frame(Date_Time, Raw_Sub[, c(-1, -2)])
for (i in c(2, 3, 4, 6, 7, 8)) {
	data[, i] <- as.numeric(as.character(data[, i]))
}
png(file = "Plot4.png")
par(mfrow = c(2, 2))
with(data, plot(Date_Time, Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power"))
with(data, plot(Date_Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(data, plot(Date_Time, Sub_metering_1, type = "l", xlab = " ", ylab = "Energy sub metering"))
lines(Date_Time, data$Sub_metering_2, type = "l", col = "red")
lines(Date_Time, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1), bty = "n")
with(data, plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()