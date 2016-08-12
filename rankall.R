rankall <- function(outcome, num = "best") {
	data <- read.csv("outcome-of-care-measures.csv", colClasses = 'character')
	data[, 11] <- suppressWarnings(as.numeric(data[, 11]))
	data[, 17] <- suppressWarnings(as.numeric(data[, 17]))
	data[, 23] <- suppressWarnings(as.numeric(data[, 23]))
	ldata <- split(data, data$State)
	if (identical(outcome, "heart attack")) {
		ldata_sort <- lapply(ldata, function(x) x[order(x[, 11], x[, 2], na.last = NA, decreasing = FALSE), ])
		if (identical(num, "best")) {
			hname <- sapply(ldata_sort, function(x) x[1, 2])
			comb <- data.frame(hname, names(hname))
			colnames(comb) <- c("hospical", "state")
			return(comb)
		}
		else if (identical(num, "worst")) {
			hname <- sapply(ldata_sort, function(x) tail(x, n = 1)[1, 2])
			comb <- data.frame(hname, names(hname))
			colnames(comb) <- c("hospical", "state")
			return(comb)
		}
		else {
			hname <- sapply(ldata_sort, function(x) x[num, 2])
			comb <- data.frame(hname, names(hname))
			colnames(comb) <- c("hospical", "state")
			return(comb)
		}

	}
	else if (identical(outcome, "heart failure")) {
		ldata_sort <- lapply(ldata, function(x) x[order(x[, 17], x[, 2], na.last = NA, decreasing = FALSE), ])
		if (identical(num, "best")) {
			hname <- sapply(ldata_sort, function(x) x[1, 2])
			comb <- data.frame(hname, names(hname))
			colnames(comb) <- c("hospital", "state")
			return(comb)
		}
		else if (identical(num, "worst")) {
			hname <- sapply(ldata_sort, function(x) tail(x, n = 1)[1, 2])
			comb <- data.frame(hname, names(hname))
			colnames(comb) <- c("hospital", "state")
			return(comb)
		}
		else {
			hname <- sapply(ldata_sort, function(x) x[num, 2])
			comb <- data.frame(hname, names(hname))
			colnames(comb) <- c("hospital", "state")
			return(comb)
		}
		
	}
	else if (identical(outcome, "pneumonia")) {
		ldata_sort <- lapply(ldata, function(x) x[order(x[, 23], x[, 2], na.last = NA, decreasing = FALSE), ])
		if (identical(num, "best")) {
			hname <- sapply(ldata_sort, function(x) x[1, 2])
			comb <- data.frame(hname, names(hname))
			colnames(comb) <- c("hospital", "state")
			return(comb)
		}
		else if (identical(num, "worst")) {
			hname <- sapply(ldata_sort, function(x) tail(x, n = 1)[1, 2])
			comb <- data.frame(hname, names(hname))
			colnames(comb) <- c("hospital", "state")
			return(comb)
		}
		else {
			hname <- sapply(ldata_sort, function(x) x[num, 2])
			comb <- data.frame(hname, names(hname))
			colnames(comb) <- c("hospital", "state")
			return(comb)
		}
	}
	else {
		stop("Invalid Outcome")
	}



}