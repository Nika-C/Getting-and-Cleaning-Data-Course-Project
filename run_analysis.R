# check/install and load packaged used in the code
if("plyr" %in% rownames(installed.packages())==FALSE){install.packages("plyr")}
if("reshape2" %in% rownames(installed.packages())==FALSE){install.packages("reshape2")}
library(plyr)
library(reshape2)

##===================================================================================================================
## 1. Merge the training and the test sets to create one data set.

#download data, unzip and set working directory into unzipped folder.
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./20Dataset.zip")
unzip("./20Dataset.zip")
setwd("./UCI HAR Dataset")

#read in text files into R as tables and merge together tables, adding in a variable for test/train.
SetTest <- read.table("./test/X_test.txt", col.names=paste("f",c(1:561),sep=""), stringsAsFactors=FALSE)
SubjTest <- read.table("./test/subject_test.txt", col.names="Subject", stringsAsFactors=FALSE)
LabelTest <- read.table("./test/Y_test.txt", col.names="Activity", stringsAsFactors=FALSE)
TestData <- cbind(SetType=rep("test",nrow(SetTest)), SubjTest, LabelTest, SetTest)

SetTrain <- read.table("./train/X_train.txt", col.names=paste("f",c(1:561),sep=""), stringsAsFactors=FALSE)
SubjTrain <- read.table("./train/subject_train.txt", col.names="Subject", stringsAsFactors=FALSE)
LabelTrain <- read.table("./train/Y_train.txt", col.names="Activity", stringsAsFactors=FALSE)
TrainData <- cbind(SetType=rep("train",nrow(SetTrain)), SubjTrain, LabelTrain, SetTrain)

#merge test and tain datasets into one data frame.
MergedData <- rbind(TestData, TrainData)

##===================================================================================================================
## 4. Appropriately labels the data set with descriptive variable names.
feature <- read.table("features.txt", stringsAsFactors=FALSE)[,2]
names(MergedData)[-(1:3)] <- feature

##===================================================================================================================
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
meanindex <- grep("mean()",names(MergedData),fixed=TRUE)
stdindex <- grep("std()",names(MergedData),fixed=TRUE)
index <- append(meanindex, stdindex)
SubsetData <- MergedData[,c(1:3,index)]

##===================================================================================================================
## 3. Uses descriptive activity names to name the activities in the data set
activitylabel <- read.table("./activity_labels.txt",stringsAsFactors=FALSE)
SubsetData$Activity <- activitylabel[SubsetData$Activity,2]

##===================================================================================================================
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
MeltedData <- melt(SubsetData, id=c("SetType","Subject","Activity"))
TidyData <- dcast(MeltedData, SetType+Subject+Activity ~ variable, mean)
View(TidyData)
