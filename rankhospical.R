rankhospital <- function(state, outcome, num = "best"){
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
		if (identical(num, "best")) {return(sub_set[1, 2])}
		else if (identical(num, "worst")) {return(sub_set[nrow(sub_set), 2])}
		else if (num > nrow(sub_set)) {return(NA)}
		else {
			rank_col <- sub_set[, 2]
			return(rank_col[num])
		}
	} else if (identical(outcome, "heart failure")) {
		data <- data[order(data[, 17], data[, 2], na.last = NA, decreasing = FALSE), ]
		sub_set <- subset(data, data$State == state)
		if (identical(num, "best")) {return(sub_set[1, 2])}
		else if (identical(num, "worst")) {return(sub_set[nrow(sub_set), 2])}
		else if (num > nrow(sub_set)) {return(NA)}
		else {
			rank_col <- sub_set[, 2]
			return(rank_col[num])
		}
	} else if (identical(outcome, "pneumonia")) {
		data <- data[order(data[, 23], data[, 2], na.last = NA, decreasing = FALSE), ]
		sub_set <- subset(data, data$State == state)
		if (identical(num, "best")) {return(sub_set[1, 2])}
		else if (identical(num, "worst")) {return(sub_set[nrow(sub_set), 2])}
		else if (num > nrow(sub_set)) {return(NA)}
		else {
			rank_col <- sub_set[, 2]
			return(rank_col[num])
		}
	} else {
		stop("Invalid Outcome")
	}
}