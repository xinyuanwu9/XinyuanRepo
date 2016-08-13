# load packages
library(dplyr)

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
SCC <- readRDS("Source_Classification_Code.rds")

# subset NEI data set and calculate the sum of emission from motor vehicle
motor_SCC <- as.character(SCC[grep("*Vehicle.*", SCC$EI.Sector), 1])
NEI_B_motor <- NEI %>% filter(fips == "24510") %>% filter(SCC %in% motor_SCC)
motor_emit <- with(NEI_B_motor, sapply(split(Emissions, year), sum))

# plot the graph using base plotting system
year <- c(1999, 2002, 2005, 2008)
png(file = "plot5.png")
plot(year, motor_emit, main = "PM25 Emission from Motor Vehicle in Baltimore", xlab = "Year", ylab = "Emission (tons)", type = "b", lwd = 2)
dev.off()