#final project
library(dplyr)

#descriptive variable names
features <- read.table("D:\\coursera\\data cleaning\\final project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt")
unique(features$V2)


#descriptive activity names
activity_labels <- read.table("D:\\coursera\\data cleaning\\final project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt")
names(activity_labels) <- c("activity_id","activity")

#read in raw dataset
trainingSet <- read.table("D:\\coursera\\data cleaning\\final project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
testSet <- read.table("D:\\coursera\\data cleaning\\final project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")

#activity
trainingLable <- read.table("D:\\coursera\\data cleaning\\final project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt")
#names(trainingLable) <- c("training_id")

testLable <- read.table("D:\\coursera\\data cleaning\\final project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")
#names(testLable) <- c("test_id")

#identifier of the subject
Subject_train <- read.table("D:\\coursera\\data cleaning\\final project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")
#names(Subject_train) <- c("subject_id")

Subject_test <- read.table("D:\\coursera\\data cleaning\\final project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")
#names(Subject_test) <- c("subject_id")


trainingSet2 <- cbind(Subject_train,trainingLable,trainingSet)
testSet2 <- cbind(Subject_test,testLable,testSet)

unique(trainingSet2[c("subject_id","training_id")])
unique(testSet2[c("subject_id","test_id")])


#1.Merges the training and the test sets to create one data set.
UCI_HAR <- rbind(trainingSet2,testSet2)

#4.Appropriately labels the data set with descriptive variable names. 
names(UCI_HAR) <- c("subject_id","activity_id",as.character(features$V2))

#the dataset has duplicated columnnames: 
#so I dedup the column and sum the value of the duplicated columns
UCI_HAR_unique<-as.data.frame(sapply(unique(names(UCI_HAR)), 
                                     function(x) rowSums( UCI_HAR[ , grep(x, names(UCI_HAR)), drop=FALSE]) ))

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
UCI_HAR_subset <- select(UCI_HAR_unique,contains("mean()"),contains("std()"),
                         contains("subject_id"),contains("activity_id"))

#3.Uses descriptive activity names to name the activities in the data set
UCI_HAR_subset2 <- merge(UCI_HAR_subset,activity_labels,by="activity_id")


#5.From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
UCI_HAR_subset3 <- group_by(UCI_HAR_subset2,subject_id,activity_id,activity)
UCI_HAR_second <- summarise_each(UCI_HAR_subset3,funs(mean))

write.table(UCI_HAR_second,"D:\\coursera\\data cleaning\\final project\\UCI_HAR.txt",row.names = F)

