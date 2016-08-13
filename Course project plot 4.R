# load the packages
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


coal_SCC <- as.character(SCC[grep("*[Cc][Oo][Aa][Ll].*", SCC$EI.Sector), 1])
NEI_coal <- filter(NEI, SCC %in% coal_SCC)
coal_emit <- with(NEI_coal, sapply(split(Emissions, year), sum))

# plot the graph using base plotting system
year <- c(1999, 2002, 2005, 2008)
png(file = "plot4.png")
plot(year, coal_emit, main = "PM25 Emission from Coal", xlab = "Year", ylab = "Emission (tons)", type = "b", lwd = 2)
dev.off()