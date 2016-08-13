# load packages
library(reshape2)
library(dplyr)
library(ggplot2)

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

# subset the data using dplyr package
data <- NEI %>% filter(fips == "24510") %>% select(type, year, Emissions)

# melt and re-make table using reshape2 package
data_melt <- melt(data, id = c("type", "year"))
data_sum <- dcast(data_melt, type + year ~ variable, sum)

# plot the graph using ggplot2 system
png(file = "plot3.png")
print(qplot(year, Emissions, data = data_sum, facets = .~type, main = "PM25 Emissions at Baltimore")
+ geom_line())
dev.off()
