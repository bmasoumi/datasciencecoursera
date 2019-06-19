# course 3 
# final project - peer graded assignment
# Author: Beeta Masoumi

# Here are the data for the project:
#         
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

# You will be required to submit: 
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, and 
# 3) a code book that describes the variables, the data, and any transformations or 
# work that you performed to clean up the data called CodeBook.md. 
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.


# Review criteria
# 1- The submitted data set is tidy.
# 2- The Github repo contains the required scripts.
# 3- GitHub contains a code book that modifies and updates the available codebooks with 
# the data to indicate all the variables and summaries calculated, along with units, 
# and any other relevant information.
# 4- The README that explains the analysis files is clear and understandable.
# 5- The work submitted for this project is the work of the student who submitted it.




# download and unzip the dataset
setwd("/Users/Beeta/Rcodes/datasciencecoursera/course3")
library(dplyr)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "/Users/Beeta/Rcodes/datasciencecoursera/course3/course3_final.zip", method="curl")
fileName <- "course3_final.zip"
if(!file.exists("/Users/Beeta/Rcodes/datasciencecoursera/course3/UCI HAR Dataset")) 
        {dir.create("/Users/Beeta/Rcodes/datasciencecoursera/course3/UCI HAR Dataset")}
unzip(fileName)

# assigning the dataframes
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
head(features)
str(features)
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
head(activities)
str(activities)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
head(subject_test)
str(subject_test)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
head(x_test)
str(x_test)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
head(y_test)
str(y_test)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
head(subject_train)
str(subject_train)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
head(x_train)
str(x_train)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
head(y_train)
str(y_train)

# Merges the training and the test sets to create one data set
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# Extracts only the measurements on the mean and standard deviation for each measurement
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# Uses descriptive activity names to name the activities in the data set
TidyData$code <- activities[TidyData$code, 2]
TidyData$code

# Appropriately labels the data set with descriptive variable names

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject

FinalData <- TidyData %>%
        group_by(subject, activity) %>%
        summarise_all(list(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

head(FinalData)
tail(FinalData)
str(FinalData)













