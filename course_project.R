library(tidyverse)

data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data_zip <- "Dataset.zip"
data_dir <- "UCI HAR Dataset"
project_dir <- "c:/Users/Robert/Dropbox/coursera/getting-and-cleaning-data/week4/"

# set working directory to initial project directory
setwd(project_dir)

# a function to ensure that the column names are valid
validate.names <- function(df){
    rtn <- df
    valid_column_names <- make.names(names=names(df), unique=TRUE, allow_ = TRUE)
    names(rtn) <- valid_column_names
    rtn
}

if (!file.exists(data_dir)) {
    
    # download the dataset if the data directory does not exist
    if (!file.exists(data_zip)) {
        download.file(data_url, destfile = data_zip, mode = "wb")
    }
    
    # unzip the data set
    unzip(data_zip, overwrite = TRUE)
}

# move into the renamed data directory
setwd(data_dir)

# read in the variables names. The features are the same in both data sets
feature_labels <- readLines("features.txt")

#
# Read in and prepare the test dataset
#

# read in the data sets
test_df <- read.table(file = "./test/X_test.txt", header = FALSE, sep = "")

# read in the subjects
test_subjects <- readLines("./test/subject_test.txt")

# assign column names to the test data set
names(test_df) <- feature_labels

# validate the column names
test_df <- validate.names(test_df)

# keep only measurements for mean or std deviation
test_df <- select(test_df, matches("mean|std"))

# read in the numeric codes that represent the activities performed
test_labels <- readLines("./test/y_test.txt")

# column bind the subjects and activity codes in front of the other columns
test_df <- cbind(test_subjects, test_labels, test_df)

# set the column names for the first two columns
names(test_df)[1] <- "subject"
names(test_df)[2] <- "activity"

#
# Read in and prepare the train dataset
#

# read in the data sets
train_df <- read.table(file = "./train/X_train.txt", header = FALSE, sep = "")

# read in the subjects
train_subjects <- readLines("./train/subject_train.txt")

# assign column names to the train data set
names(train_df) <- feature_labels

# validate the columns names
train_df <- validate.names(train_df)

# keep only measurements for mean or std deviation
train_df <- select(train_df, matches("mean|std"))

# read in the numeric codes that represent the activities performed
train_labels <- readLines("./train/y_train.txt")

# column bind the subjects and activity codes in front of the other columns
train_df <- cbind(train_subjects, train_labels, train_df)

# set the column names for the first two columns
names(train_df)[1] <- "subject"
names(train_df)[2] <- "activity"

#
# Combine the data sets
#

# merge the data sets by row binding 
combined_df <- rbind(train_df, test_df)

# remove these objects to recover memory
rm(train_df, test_df)

# clean up the variable (column) names
names(combined_df) <- gsub("[\\.]+", "-", colnames(combined_df))
names(combined_df) <- gsub("[-]+$", "", colnames(combined_df))

# read the activities data in a data frame. This will allow replacement of numeric
# activity codes with human readable descriptions
activities_df <- read.table(file = "activity_labels.txt", header = FALSE, sep = "")

# replace activity number with readable description
combined_df$activity <- activities_df[,2][match(combined_df$activity, activities_df[,1])]

# take the mean of all columns grouped by subject and activity
tidy_df <- aggregate(combined_df[, 3:ncol(combined_df)], 
                     list(combined_df$subject,combined_df$activity), mean)

# restore the columns names that aggregate changed.
names(tidy_df)[1] <- "subject"
names(tidy_df)[2] <- "activity"

# order the tidy.df data frame by subject, then activity.
tidy_df <- tidy_df[with(tidy_df, order(subject,activity)), ]

# go back to the project directory
setwd(project_dir)

# write the data file ready for upload
write.table(tidy_df, "tidy.csv", sep=",", row.names=FALSE)
