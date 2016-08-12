# download the compressed zip file from the web
filename <- "getdata_dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(filename)) {
	download.file(fileURL, filename)
}
 
# unzip the file
if (!file.exists("UCI HAR Dataset")) { 
	unzip(filename)
} 

# read labels of activities and features
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", colClasses = c("integer", "character"))
features <- read.table("UCI HAR Dataset/features.txt", colClasses = c("integer", "character"))

# search "mean" and "std" in features and returns a subset index
features_subset <- grep(".*[Mm][Ee][Aa][Nn].*|.*[Ss][Tt][Dd].*", features[,2])
# subset features and returns a vector
features2 <- features[features_subset,2]
# clean the names of variables
features2 <- gsub('[()-]', '', features2)
features2 <- gsub('mean', 'Mean', features2)
features2 <- gsub('std', 'Std', features2)

# read the train data, combines with subject and activities numbers, and subset according to features of interest.
data_train <- read.table("UCI HAR Dataset/train/X_train.txt")
data_train_subset <- data_train[, features_subset]
activities_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
data_train <- data.frame(subjects_train, activities_train, data_train_subset)

# read the test data, then combines with subject and activities numbers, and subset according to features of interest.
data_test <- read.table("UCI HAR Dataset/test/X_test.txt")
data_test_subset <- data_test[, features_subset]
activities_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
data_test <- data.frame(subjects_test, activities_test, data_test_subset)

# combine train data with test data and assign column names to the full data
data_full <- rbind(data_test, data_train)
colnames(data_full) <- c("subject", "activity", features2)

# convert the first two columns to factor
data_full$activity <- factor(data_full$activity, levels = activity_labels[,1], labels = activity_labels[,2])
data_full$subject <- factor(data_full$subject)

# use the reshape2 package variable to melt the data frame with id being the first two columns
library(reshape2)
data_full_melt <- melt(data_full, id = c("subject", "activity"))
# use dcast function to build the final tidy data frame by taking the average with respect to subject and activities
data_full_mean <- dcast(data_full_melt, subject + activity ~ variable, mean)

# export the tidy data to a text file
write.table(data_full_mean, "tidy.txt", row.names = FALSE)
