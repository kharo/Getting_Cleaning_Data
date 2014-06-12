CodeBook.md

The R script run_analysis.R imports the raw data from the Samsung Galaxy S Smartphone accelerometer, which can be found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data were originally partitioned into a training and a test set of data, containing separate files for the subject ID (who was performing the activity), the activities themselves, and the accelerometer data from the smart phone.  The latter data was merged with the ID and Activity identifiers to create a dataset of raw readings.  The script run_analysis.R imports the data in two steps, first on the training data, then on the test data.  The data sets are then merged and converts the codes for subject activity from integer values 1-6 to the activities ‘LAYING’, ‘SITTING’, ‘STANDING’, ‘WALKING’, ‘WALKING UP’, and ‘WALKING DOWN’.  Otherwise, no transformations of the data take place.  Subject ID’s are still referred to as their unique subject ID number, valued 1-30.  The data originally contained these two variable identifiers plus the 561 quantitative variables, which are reported in normalized, unit-less values.  There are a total of 10,299 observations of these data across the 563 total variables.

Only variables that represented a mean and standard deviation, identified from the original variable names by searching for ‘mean’ or ‘std’ in the name, were included in the analysis and final output data, which came to a total of 79 quantitative variables.  Finally, an average of each combination of Subject_ID and Subject_Activity was calculated and included in the output dataset.  With 30 subjects performing 6 activities, this resulted in a dataset consisting of 180 rows for each combination, with a total of 81 column names, one for the subject ID, one for the subject activity, and the 79 average values of each quantitative variable.  The variable names were converted in the following way, to be more comprehendible and descriptive (descriptions of the variables are at the end of the document).

Original names:
[1] "tBodyAcc-mean()-X"               "tBodyAcc-mean()-Y"               "tBodyAcc-mean()-Z"               "tBodyAcc-std()-X"               
 [5] "tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"                "tGravityAcc-mean()-X"            "tGravityAcc-mean()-Y"           
 [9] "tGravityAcc-mean()-Z"            "tGravityAcc-std()-X"             "tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"            
[13] "tBodyAccJerk-mean()-X"           "tBodyAccJerk-mean()-Y"           "tBodyAccJerk-mean()-Z"           "tBodyAccJerk-std()-X"           
[17] "tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"            "tBodyGyro-mean()-X"              "tBodyGyro-mean()-Y"             
[21] "tBodyGyro-mean()-Z"              "tBodyGyro-std()-X"               "tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"              
[25] "tBodyGyroJerk-mean()-X"          "tBodyGyroJerk-mean()-Y"          "tBodyGyroJerk-mean()-Z"          "tBodyGyroJerk-std()-X"          
[29] "tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"           "tBodyAccMag-mean()"              "tBodyAccMag-std()"              
[33] "tGravityAccMag-mean()"           "tGravityAccMag-std()"            "tBodyAccJerkMag-mean()"          "tBodyAccJerkMag-std()"          
[37] "tBodyGyroMag-mean()"             "tBodyGyroMag-std()"              "tBodyGyroJerkMag-mean()"         "tBodyGyroJerkMag-std()"         
[41] "fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"               "fBodyAcc-mean()-Z"               "fBodyAcc-std()-X"               
[45] "fBodyAcc-std()-Y"                "fBodyAcc-std()-Z"                "fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"          
[49] "fBodyAcc-meanFreq()-Z"           "fBodyAccJerk-mean()-X"           "fBodyAccJerk-mean()-Y"           "fBodyAccJerk-mean()-Z"          
[53] "fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"            "fBodyAccJerk-std()-Z"            "fBodyAccJerk-meanFreq()-X"      
[57] "fBodyAccJerk-meanFreq()-Y"       "fBodyAccJerk-meanFreq()-Z"       "fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"             
[61] "fBodyGyro-mean()-Z"              "fBodyGyro-std()-X"               "fBodyGyro-std()-Y"               "fBodyGyro-std()-Z"              
[65] "fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"          "fBodyGyro-meanFreq()-Z"          "fBodyAccMag-mean()"             
[69] "fBodyAccMag-std()"               "fBodyAccMag-meanFreq()"          "fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-std()"      
[73] "fBodyBodyAccJerkMag-meanFreq()"  "fBodyBodyGyroMag-mean()"         "fBodyBodyGyroMag-std()"          "fBodyBodyGyroMag-meanFreq()"    
[77] "fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-std()"      "fBodyBodyGyroJerkMag-meanFreq()"

Modified Names:
[1] "Acceleration_Mean_X"                        "Acceleration_Mean_Y"                        "Acceleration_Mean_Z"                       
 [4] "Acceleration_SD_X"                          "Acceleration_SD_Y"                          "Acceleration_SD_Z"                         
 [7] "Gravity_Acceleration_Mean_X"                "Gravity_Acceleration_Mean_Y"                "Gravity_Acceleration_Mean_Z"               
[10] "Gravity_Acceleration_SD_X"                  "Gravity_Acceleration_SD_Y"                  "Gravity_Acceleration_SD_Z"                 
[13] "Acceleration_Jerk_Mean_X"                   "Acceleration_Jerk_Mean_Y"                   "Acceleration_Jerk_Mean_Z"                  
[16] "Acceleration_Jerk_SD_X"                     "Acceleration_Jerk_SD_Y"                     "Acceleration_Jerk_SD_Z"                    
[19] "Gyroscope_Mean_X"                           "Gyroscope_Mean_Y"                           "Gyroscope_Mean_Z"                          
[22] "Gyroscope_SD_X"                             "Gyroscope_SD_Y"                             "Gyroscope_SD_Z"                            
[25] "Gyroscope_Jerk_Mean_X"                      "Gyroscope_Jerk_Mean_Y"                      "Gyroscope_Jerk_Mean_Z"                     
[28] "Gyroscope_Jerk_SD_X"                        "Gyroscope_Jerk_SD_Y"                        "Gyroscope_Jerk_SD_Z"                       
[31] "Acceleration_Magnitude_Mean"                "Acceleration_Magnitude_SD"                  "GravityAcceleration_Magnitude_Mean"        
[34] "GravityAcceleration_Magnitude_SD"           "Acceleration_Jerk_Magnitude_Mean"           "Acceleration_Jerk_Magnitude_SD"            
[37] "Gyroscope_Magnitude_Mean"                   "Gyroscope_Magnitude_SD"                     "Gyroscope_Jerk_Magnitude_Mean"             
[40] "Gyroscope_Jerk_Magnitude_SD"                "Acceleration_Mean_X"                        "Acceleration_Mean_Y"                       
[43] "Acceleration_Mean_Z"                        "Acceleration_SD_X"                          "Acceleration_SD_Y"                         
[46] "Acceleration_SD_Z"                          "Acceleration_Mean_Frequency_X"              "Acceleration_Mean_Frequency_Y"             
[49] "Acceleration_Mean_Frequency_Z"              "Acceleration_Jerk_Mean_X"                   "Acceleration_Jerk_Mean_Y"                  
[52] "Acceleration_Jerk_Mean_Z"                   "Acceleration_Jerk_SD_X"                     "Acceleration_Jerk_SD_Y"                    
[55] "Acceleration_Jerk_SD_Z"                     "Acceleration_Jerk_Mean_Frequency_X"         "Acceleration_Jerk_Mean_Frequency_Y"        
[58] "Acceleration_Jerk_Mean_Frequency_Z"         "Gyroscope_Mean_X"                           "Gyroscope_Mean_Y"                          
[61] "Gyroscope_Mean_Z"                           "Gyroscope_SD_X"                             "Gyroscope_SD_Y"                            
[64] "Gyroscope_SD_Z"                             "Gyroscope_Mean_Frequency_X"                 "Gyroscope_Mean_Frequency_Y"                
[67] "Gyroscope_Mean_Frequency_Z"                 "Acceleration_Magnitude_Mean"                "Acceleration_Magnitude_SD"                 
[70] "Acceleration_Magnitude_Mean_Frequency"      "Acceleration_Jerk_Magnitude_Mean"           "Acceleration_Jerk_Magnitude_SD"            
[73] "Acceleration_Jerk_Magnitude_Mean_Frequency" "Gyroscope_Magnitude_Mean"                   "Gyroscope_Magnitude_SD"                    
[76] "Gyroscope_Magnitude_Mean_Frequency"         "Gyroscope_Jerk_Magnitude_Mean"              "Gyroscope_Jerk_Magnitude_SD"               
[79] "Gyroscope_Jerk_Magnitude_Mean_Frequency"

The features of the dataset, based on the original names, are described below.  Recall that only the transformed values of mean and standard deviation, per assignment instructions, were extracted from this dataset and are shown above.

Feature Selection 
================
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  

'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
Acceleration_Mean_XYZ
Gravity_Acceleration_Mean_XYZ
Acceleration_Jerk_Mean_XYZ
Gyroscope_Mean_XYZ
Gyroscope_Jerk_Mean_XYZ
Acceleration_Magnitude_Mean
Gravity_Acceleration_Magnitude_Mean
Acceleration_Jerk_Magnitude_Mean
Gyroscope_Magnitude_Mean
Gyroscope_Jerk_Magnitude_Mean
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean




