best <- function(state, outcome){
	data <- read.csv("outcome-of-care-measures.csv", colClasses = 'character')
	data[, 11] <- suppressWarnings(as.numeric(data[, 11]))
	data[, 17] <- suppressWarnings(as.numeric(data[, 17]))
	data[, 23] <- suppressWarnings(as.numeric(data[, 23]))
	if(!(as.character(state) %in% data$State)) {
		stop("Invalid State")
	}
	if (identical(outcome, "heart attack")) {
		data <- data[order(data[, 11], data[, 2], na.last = NA, decreasing = FALSE), ]
		sub_set <- subset(data, data$State == state)
		return(sub_set[1, 2])
	} else if (identical(outcome, "heart failure")) {
		data <- data[order(data[, 17], data[, 2], na.last = NA, decreasing = FALSE), ]
		sub_set <- subset(data, data$State == state)
		return(sub_set[1, 2])
	} else if (identical(outcome, "pneumonia")) {
		data <- data[order(data[, 23], data[, 2], na.last = NA, decreasing = FALSE), ]
		sub_set <- subset(data, data$State == state)
		return(sub_set[1, 2])
	} else {
		stop("Invalid Outcome")
	}
}