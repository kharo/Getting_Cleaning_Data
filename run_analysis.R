####################################################################################################################################
# NOTE: Provided this file, run_analysis.R, is used to determine and set the working directory, and the Samsung Data are in that same directory, then
#  simply selecting "source on save" followed by hitting the save button should reproduce the tidy output data called "Tidy_Data.txt"
####################################################################################################################################

# STEP 1: IMPORT AND CLEAN TRAINING DATA
# import the subjects on the training set into main data frame called 'df' and rename columns to subject identification number
directory = getwd()
df = read.table(paste(directory,'/subject_train.txt',sep = ''), quote="\"")
names(df)[names(df)=='V1'] = 'Subject_ID'

# import the activites column in the training set, replace category with actual activity, and append to the main dataset df
activities = read.table(paste(directory, '/y_train.txt', sep=''), quote="\"")
text = c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING')
for (i in 1:6){
  activities[activities==i] = text[i]
}
df = cbind(df, activities)
names(df)[names(df)=='V1'] = 'Subject_Activity'

# import training measurements and append to dataset df
X_train <- read.table(paste(directory,'/X_train.txt',sep = ''), quote="\"")
df = cbind(df, X_train)
rm(X_train)

# STEP 2: IMPORT AND CLEAN TEST DATA, THEN MERGE
# import the subjects on the test set into secondary data frame called 'df2'
df2 <- read.table(paste(directory, '/subject_test.txt', sep = ''), quote="\"")
names(df2)[names(df2)=='V1'] = 'Subject_ID'

# import the activites column from the test set, replace category with actual activity, and append to the secondary dataset df2
activities = read.table(paste(directory, '/y_test.txt', sep = ''), quote="\"")
text = c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS','SITTING','STANDING','LAYING')
for (i in 1:6){
  activities[activities==i] = text[i]
}
df2 = cbind(df2, activities)
names(df2)[names(df2)=='V1'] = 'Subject_Activity'
rm(i,activities,text)

# import test measurements and append to dataset df2
X_test <- read.table(paste(directory, '/X_test.txt', sep = ''), quote="\"")
df2 = cbind(df2, X_test)
rm(X_test)

# combine test and training datasets to main dataset 'df'
df = rbind(df, df2)
rm(df2)

# STEP 3: REDUCE DATASET SIZE AND CLARIFY VARIABLE/COLUMN NAMES
# import variable names to only include the measurements that are mean and standard deviations
variable_names = read.table(paste(directory, '/features.txt', sep = ''), quote="\"")
variable_names = as.character(variable_names[,2])

# remove the transformation vectors provided at end of the dataset (see README file for explanation)
variable_names = variable_names[1:554]

# identify the column indices of mean and std measurements & subset only the desired columns of 'df'
id1 = grep('mean', variable_names)
id2 = grep('std', variable_names)
id = sort(c(1,2, 2+id1, 2+id2))
df = df[,id]

# create a string of the column names and clean up the names to insert them back into dataset 'df'
id = sort(c(id1,id2))
column_names = c('Subject_ID','Subject_Activity',variable_names[id])
rm(id, id1, id2, variable_names, directory)

# clean up irregularities in variable names
column_names = gsub('tB','B',column_names)
column_names = gsub('fB','B',column_names)
column_names = gsub('tG','G',column_names)
column_names = gsub('\\()-','',column_names)
column_names = gsub('\\()','',column_names)
column_names = gsub('-','_',column_names)
column_names = gsub('Body','',column_names)
column_names = gsub('X','_X',column_names)
column_names = gsub('Y','_Y',column_names)
column_names = gsub('Z','_Z',column_names)
column_names = gsub('GravityAcc_mean','Gravity_Acceleration_Mean',column_names)
column_names = gsub('GravityAcc_std','Gravity_Acceleration_SD',column_names)
column_names = gsub('Acc_mean','Acceleration_Mean',column_names)
column_names = gsub('Acc_std','Acceleration_SD',column_names)
column_names = gsub('AccJerk_mean','Acceleration_Jerk_Mean',column_names)
column_names = gsub('AccJerk_std','Acceleration_Jerk_SD',column_names)
column_names = gsub('Gyro_mean','Gyroscope_Mean',column_names)
column_names = gsub('Gyro_std','Gyroscope_SD',column_names)
column_names = gsub('GyroJerk_mean','Gyroscope_Jerk_Mean',column_names)
column_names = gsub('GyroJerk_std','Gyroscope_Jerk_SD',column_names)
column_names = gsub('AccMag_mean','Acceleration_Magnitude_Mean',column_names)
column_names = gsub('AccMag_std','Acceleration_Magnitude_SD',column_names)
column_names = gsub('AccJerkMag_mean','Acceleration_Jerk_Magnitude_Mean',column_names)
column_names = gsub('AccJerkMag_std','Acceleration_Jerk_Magnitude_SD',column_names)
column_names = gsub('GyroMag_mean','Gyroscope_Magnitude_Mean',column_names)
column_names = gsub('GyroMag_std','Gyroscope_Magnitude_SD',column_names)
column_names = gsub('GyroJerkMag_mean','Gyroscope_Jerk_Magnitude_Mean',column_names)
column_names = gsub('GyroJerkMag_std','Gyroscope_Jerk_Magnitude_SD',column_names)
column_names = gsub('Freq','_Frequency',column_names)
names(df)[1:81] = column_names
rm(column_names)

# STEP 4: REDUCE DATASET BY AVERAGING OBSERVATIONS FOR EACH SUBJECT BY ACTIVITY
df_tidy = matrix(nrow = 180, ncol = 81)
df_tidy[,1] = rep(seq(1,30,by=1), times = 6)
df_tidy[,2] = c(rep('LAYING',30), rep('SITTING',30), rep('STANDING',30), rep('WALKING',30), rep('WALKING DOWN',30), rep('WALKING UP',30))

for (i in 3:length(df)){
  df_tidy[,i] = as.vector(tapply(X = df[,i], INDEX = list(df$Subject_ID, df$Subject_Activity), FUN = mean))
}

df_tidy = as.data.frame(df_tidy)
names(df_tidy) = names(df)
write.table(df_tidy, file = 'Tidy_Data.txt', row.names = F)
rm(df_tidy, df, i)
