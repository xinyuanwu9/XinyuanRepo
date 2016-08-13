# download the data and load the pm25 file
filename <- "exdata%2Fdata%2FNEI_data.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists(filename)) {
	download.file(fileURL, filename)
}
if (!file.exists("summarySCC_PM25.rds")) { 
	unzip(filename)
} 
NEI <- readRDS("summarySCC_PM25.rds")

# calculate the sum of emission for each year
NEI$year <- factor(NEI$year)
year_emit <- with(NEI, sapply(split(Emissions, year), sum))

# plot the emission vs. year using base plotting system
year <- c(1999, 2002, 2005, 2008)
png(file = "plot1.png")
plot(year, year_emit, main = "Total Emission", xlab = "Year", ylab = "Total Emission (tons)", type = "b", lwd = 2)
dev.off()