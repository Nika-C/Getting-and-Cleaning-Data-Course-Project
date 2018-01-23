# Getting-and-Cleaning-Data-Course-Project


Check if packages used in the code are installed, install if not and load the package into the session.
```r
if("plyr" %in% rownames(installed.packages())==FALSE){install.packages("plyr")}
if("reshape2" %in% rownames(installed.packages())==FALSE){install.packages("reshape2")}
library(plyr)
library(reshape2)
```

Download file from the web, unzip and set working directory into the unzipped folder for easier access to data files.
```r
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./20Dataset.zip")
unzip("./20Dataset.zip")
setwd("./UCI HAR Dataset")
```

Read in the three text files containing information about the processed signal data, subject, and activity lables into R, using the `read.table` function. Name the columns appropriately, and use `stingsAsFactors=False` for easier handling of the data. The column names for `SetTest` is arbitrarily labeled as "f1~f561" for simplicity. (Detailed information in the folder 'Inertial Signals' seems unnecessary to read in as it is already processed into a single dataset in the signal data (i.e. subject_test.txt.))
```r
SetTest <- read.table("./test/X_test.txt", col.names=paste("f",c(1:561),sep=""), stringsAsFactors=FALSE)
SubjTest <- read.table("./test/subject_test.txt", col.names="Subject", stringsAsFactors=FALSE)
LabelTest <- read.table("./test/Y_test.txt", col.names="Activity", stringsAsFactors=FALSE)
```
Combine the three tables with `cbind`, adding in a variable `SetType` that indicates that it is the test set.
```r
TestData <- cbind(SetType=rep("test",nrow(SetTest)), SubjTest, LabelTest, SetTest)
```

Do the same for the Train set
```r
SetTrain <- read.table("./train/X_train.txt", col.names=paste("f",c(1:561),sep=""), stringsAsFactors=FALSE)
SubjTrain <- read.table("./train/subject_train.txt", col.names="Subject", stringsAsFactors=FALSE)
LabelTrain <- read.table("./train/Y_train.txt", col.names="Activity", stringsAsFactors=FALSE)
TrainData <- cbind(SetType=rep("train",nrow(SetTrain)), SubjTrain, LabelTrain, SetTrain)
```

**Merge test and tain datasets into one data frame.**
```r
MergedData <- rbind(TestData, TrainData)
```


Take the feature description list from the `features.txt` file and use it to **appropriately label the data set with descriptive variable names**. `[-(1:3)]` is used to skip the three added variable (SetType, Subject, and Activity) that doesn't correspond to features.
```r
feature <- read.table("features.txt", stringsAsFactors=FALSE)[,2]
names(MergedData)[-(1:3)] <- feature
```

Use `grep` to get the index of feature names with the string "mean()" for mean and "std()" for standard deviation, put it together and subset the data using the index to **extract only the measurements on the mean and standard deviation for each measurement**. `c(1:3,index)` is used to retain the first three variables that doesn't correspond to features.
```r
meanindex <- grep("mean()",names(MergedData),fixed=TRUE)
stdindex <- grep("std()",names(MergedData),fixed=TRUE)
index <- append(meanindex, stdindex)
SubsetData <- MergedData[,c(1:3,index)]
```

Read in activity label text and use it to replace the 'Activity' variable with **descriptive activity names** instead of the label numbers. The `[SubsetData$Activity,2]` uses the number in the 'Activity' column as an index to bring out the desciptive name in the 2<sup>nd</sup> column.
```r
activitylabel <- read.table("./activity_labels.txt",stringsAsFactors=FALSE)
SubsetData$Activity <- activitylabel[SubsetData$Activity,2]
```

 Melt the dataset into a narrow column retaining variables SetType, Subject, and Activity. Cast the data using `dcast`, categorizing by Subject and Activity and summarizing the variable (which corresponds to the features), using the mean function. The resulting dataset is **an independent tidy data set with the average of each variable for each activity and each subject.*** `SetType` is not necessary in `dcast`, but optionally added as a indicator flag for whether the subject is from the test set or the train set.
```r
MeltedData <- melt(SubsetData, id=c("SetType","Subject","Activity"))
TidyData <- dcast(MeltedData, SetType+Subject+Activity ~ variable, mean)
```

View the resulting Tidy Data.
```r
View(TidyData)
```
