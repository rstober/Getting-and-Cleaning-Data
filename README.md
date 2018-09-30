# Getting and Cleaning Data: Course Project

This is the repository for the Getting and Cleaning Data course project. The repository contains the following files:

* README.rmd: This readme file.
* CodeBook.rmd: The codebook that lists the files and variables used in the analysis. 
* course_project.R: This is an R script that downloads, merges, and aggregates the test and training data sets. 

The course_project.R script performs the following operations:

### 1. Downloads and unzips the data set

* Downloads the complete data set if it doesn't already exist in the working directory.
* Unzips the data set if the unzipped directory doesn't exist.

### 2. Builds the list of column names

* Reads in the features.txt file to obtain the column labels for all 561 columns in the data set. The columns names are stored in a vector called feature_labels. The column names are identical in both the test and training data files.
* Reduces feature_labels to include only the labels for columns representing mean and std deviation.
* Replaces spaces in feature_labels with hyphens.
* Adds column names for the subject and activity IDs. Note that this operation is performed after the feature labels are assigned to the columns in step 3, below.

### 3. Reads in and prepares the data sets

The following operations are performed on both the test and training data sets.
* Reads in the activities from the activities files.
* Reads in the subjects from the subjects files.
* Reads in the test and training data sets from the data files. The result is two data frames, test_df and train_df.
* Column binds the subjects and activities vectors to the data frames.
* Assigns names to each column from the features_labels vector. The result is that each column is given the name of the feature it represents.
* Drops all the columns that don't represent mean or standard deviation measurements.

### 4. Merges the test and training data sets into a combined data set

The code uses rbind to merge the data sets.

### 5. Aggregates and sorts each column by subject and activity 

* The result is a data frame named tidy_df that contains one row for each subject-activity (180 rows in total).
* Each row contains the mean of all the observations for a particular subject and activity. (6 rows for each subject).
* The rows are sorted by subject and then by activity.

### 6. Writes the tidy.txt file 

* Writes the file using the tidy.df data frame via the write.file function.
* This is a comma delimited text file (CSV).
