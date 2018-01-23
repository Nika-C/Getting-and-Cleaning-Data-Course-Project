# Code Book

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called .

## Description of the Variables & Data

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Feature Variable | Unit |
-----------------|------|
tBodyAcc-XYZ | m/s<sup>2</sup> |
tGravityAcc-XYZ | m/s<sup>2</sup> |
tBodyAccJerk-XYZ | m/s<sup>2</sup> |
tBodyGyro-XYZ | rad/s |
tBodyGyroJerk-XYZ | rad/s |
tBodyAccMag | m/s<sup>2</sup> |
tGravityAccMag | m/s<sup>2</sup> |
tBodyAccJerkMag | m/s<sup>2</sup> |
tBodyGyroMag | rad/s |
tBodyGyroJerkMag | rad/s |
fBodyAcc-XYZ | m/s<sup>2</sup> |
fBodyAccJerk-XYZ | m/s<sup>2</sup> |
fBodyGyro-XYZ | rad/s |
fBodyAccMag | m/s<sup>2</sup> |
fBodyAccJerkMag | m/s<sup>2</sup> |
fBodyGyroMag | rad/s |
fBodyGyroJerkMag | rad/s |

Sets of variables that were estimated from these signals include: 
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array

Among these variables, only the Mean value and Standard deviation of each features were taken in the cleanup process. The complete list of variables of each feature vector is available in 'features.txt' of the original download files.


## Clean Up Process

1. All the data files were loaded into R, and the set data, label and subject data were merged into one table for each test and training sets. Columns for label and subject data were named as “Activity” and “Subject”, respectively.
2. A column was added to both test and training set table identifying if it is a test or training set, under the column name “SetType”.
3. The two tables were merged into one.
4. The set data variables were named accordingly as the 561-features in the “features.txt” file.
5. The data was subsetted to include only the Mean value(mean()) and Standard deviation(std()) from the feature variables.
6. Labels shown in numbers were replaced with corresponding Activity description.
7. Data with the same Subject and Activity variables were collated into one average value.
