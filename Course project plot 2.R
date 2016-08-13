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

# subset the Baltimore City data, calculate the sum of emission for each year
NEI$year <- factor(NEI$year)
NEI_B <- subset(NEI, fips == "24510")
year_emit_B <- with(NEI_B, sapply(split(Emissions, year), sum))

# plot the emission in Baltimore City vs. year using base plotting system
year <- c(1999, 2002, 2005, 2008)
png(file = "plot2.png")
plot(year, year_emit_B, main = "Total Emission in Baltimore City", xlab = "Year", ylab = "Total Emission (tons)", type = "b", lwd = 2)
dev.off()