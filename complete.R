complete <- function(directory, id = 1:332){
	files <- list.files(directory, full.names = TRUE)
	data <- data.frame()
	for (i in id){
		csv <- read.csv(files[i])
		row <- data.frame(i, sum(complete.cases(csv)))
		data <- rbind(data, row)}
	colnames(data) <- c("id", "nobs")
	data
}