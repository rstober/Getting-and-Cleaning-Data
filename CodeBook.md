This code book describes the files and variables used to produce the tidy data set (tidy.txt). The file paths assume that the 
working directory is the directory that contains the script "course_project.R".

## Files 

course_project.R: This is an R script that downloads, merges, and aggregates the test and training Samsung data sets. It is the only file that exists at the beginning of the analysis. 

* Dataset.zip: This the complete data set the analysis is performed on. It is downloaded by the script if it doesn't 
already exist. It contains the UCI HAR Dataset directory, which contains all the files listed below.

* tidy.txt: This is the tidy output file written by the course_project.R script. 

* UCI HAR Dataset/features.txt: This is the list of the 561 features contained in the data set, one feature per line. These are 
read into the vector feature.labels and used to name the columns in the data set from left to right.

* UCI HAR Dataset/activity_labels.txt: This is the table of activity codes with descriptive names for each activity.

* UCI HAR Dataset/test/X_test.txt: This is the data set that contains the data for the subjects in the test group.

* UCI HAR Dataset/test/y_test.txt: This is the list of activity codes for each row in the test data set.

* UCI HAR Dataset/test/subject_test.txt: This is the list of subject codes for each row in the test data set.

* UCI HAR Dataset/train/X_train.txt: This is the data set that contains the data for the subjects in the train group.

* UCI HAR Dataset/train/y_train.txt: This is the list of activity codes for each row in the train data set.

* UCI HAR Dataset/train/subject_train.txt: This is the list of subject codes for each row in the train data set.

## Variables

* feature_labels: A vector containing the descriptive name for each feature name (column name) common to both the test and train data sets.

* activities_df: A data frame that contains the mapping of numeric activity codes to human readable activity descriptions. This mapping is applicable to both data sets.

* test_df: A data frame that contains the data for the subjects in test group.

* test_subjects: A vector that contains the list of subject codes for each row in the test data set.

* train_df: A data frame that contains the data for the subjects in train group.

* train_subjects: A vector that contains the list of subject codes for each row in the train data set.

* combined_df: A data frame that contains the data for the subjects in both the test and train groups.

* tidy_df: A data frame that contains the aggregated, ordered data for both the test and train groups.

## Codes

The first two columns of tidy data set ("subject" and "activity") contain integers that represent the persons that participated 
in the study, and the six activities each participant performed during the study.

* subject: The data set does not contain information that can be used to link the subject id provided with any actual person.  

* activity: The activitiy codes are given in the file activity_labels.txt.

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
