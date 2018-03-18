# Getting-and-Cleaning-Data-Course-Project
This Repository contians all the files necessary to process the data contained in the data folder.

## Files and Folders
- **Data** - make sure this folder is in your working directory when you run run_anaylsis.R  
  has the raw data files from : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
-**activity_lables.txt** - a table with the activitys and the ids used to link this data up with train_y or test_y  
-**features.txt** - tab seperated of all the features in the train_x and test_x data set. Has all original features from raw dataset  
-**Features_info.txt** - explains features from Raw dataset  
-**README_Original.txt** - the original readme from the raw data set  
-**run_analysis.R** - the script ran with the Data folder in you working directory to produce the tidydata csv  
-**tidydata.csv** -   the tidy data that the run_analysis script produces  


## Analysis Summary
This analysis only works with the Data folder in the working directory
1. Merge the training and the test sets to create one data set
  to do this I create a function called 'fitdatacleanup.'  This function takes the words 'train' or 'test'
   it reads the appropraite tables into R and puts sets the column names to what they are in the features file.
   then it does a join on the Y data and the activity names.  after that I use cbind to merge the subjects the data and the activities
   I finally run the fitdatacleanup on test and train and rbind the results to merge the datasets.

2. Extract only the measurements on the mean and standard deviation for each measurement
  I use grepl to subset out anything that does not have the words 'std' or 'mean'

3. Uses descriptive activity names to name the activities in the data set
  I use gsub to expand the abrivations.  this will be further explained in the codebook.MD in this repository. 
4. Appropriately labels the data set with descriptive variable names
  I did this in the fitdatacleanup function when I joined the activity name file on y.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  I use the dplyr package to create this dataframe.
