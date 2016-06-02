# GetAndCleanData
Coursera assignment: Getting and Cleaning Data Course Project


This readme file is about the structure of my code: run_analysis.R.

First, read in txt file:  features.txt, activity_labels.txt, X_train.txt, X_test.txt, y_train.txt, y_test.txt, subject_train.txt, subject_test.txt.

For either trainingSet or testSet, bind columns of raw data, acitvity, identifier of subject.  

And the check: for either trainingSet or testSet, 
     for subject of 1-30, each of them should only have 1-6 activities.
     
Then:
     1.Merges the training and the test sets to create one data set.
     2.Appropriately labels the data set with descriptive variable names. 
After the above steps, I find there are duplicated columns in the dataset: so I dedup the column names and add the value of the same columns.
     3.Extracts only the measurements on the mean and standard deviation for each measurement.
     4.Uses descriptive activity names to name the activities in the data set
     5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
