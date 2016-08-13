# load packages
library(dplyr)
library(reshape2)
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
SCC <- readRDS("Source_Classification_Code.rds")

# subset NEI data set and calculate the sum of emission from motor vehicle
motor_SCC <- as.character(SCC[grep("*Vehicle.*", SCC$EI.Sector), 1])
NEI_motor <- NEI %>% filter(fips == "24510" | fips == "06037") %>% filter(SCC %in% motor_SCC) %>% select(fips, year, Emissions)

# calculate the sum of emissions for each county for each year
NEI_motor_melt <- melt(NEI_motor, id = c("fips", "year"))
NEI_motor_sum <- dcast(NEI_motor_melt, fips + year ~ variable, sum)
NEI_motor_sum$fips <- factor(NEI_motor_sum$fips, labels = c("Los Angeles County", "Baltimore City"))

# plot the graph using ggplot2 system
png(file = "plot6.png")
print(ggplot(NEI_motor_sum, aes(x = year, y = Emissions, group = fips)) 
+ geom_line(aes(linetype = fips, color = fips), size = 1.5) 
+ geom_point(aes(shape = fips, color = fips), size = 4)
+ scale_shape(solid = F)
+ labs(x = "Year", y = "Emission (tons)"))
dev.off()
