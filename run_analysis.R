## 1. Merge the training and the test sets to create one data set.

## read training data
trainingdata_subject <- read.csv("UCI HAR Dataset/train/subject_train.txt")
trainingdata_activities <- read.csv("UCI HAR Dataset/train/y_train.txt")
trainingdata_data <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="")

## read test data
testdata_subject <- read.csv("UCI HAR Dataset/test/subject_test.txt")
testdata_activities <- read.csv("UCI HAR Dataset/test/y_test.txt")
testdata_data <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="")

## read labels_X (4. Appropriately labels the data set with descriptive variable names.)
labels_X <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
labels_X <- labels_X[,2]

## change names 
names(trainingdata_subject) <- "subject"
names(trainingdata_activities) <- "activity"
names(trainingdata_data) <- labels_X

names(testdata_subject) <- "subject"
names(testdata_activities) <- "activity"
names(testdata_data) <- labels_X

## join the datasets
trainingdata <- trainingdata_subject
trainingdata <- cbind(trainingdata, trainingdata_activities)
trainingdata <- cbind(trainingdata, trainingdata_data)

testdata <- testdata_subject
testdata <- cbind(testdata, testdata_activities)
testdata <- cbind(testdata, testdata_data)

alldata <- rbind(trainingdata, testdata)


# 2. Extract only the measurements on the mean and standard deviation for each measurement.
##mean_std_cols <- grep('mean|std', names(alldata))
mean_std_cols <- setdiff(grep("mean|std", names(alldata)), grep("Freq", names(alldata))) # get all columnames containing "mean" or "std", but not the "meanFreq" columns
relevant_cols <- c(1,2,mean_std_cols) # to work with the data we also need the subject and activity information which we find in columns 1 and 2
relevant_data <- alldata[,relevant_cols] # store the relevant columns for all rows in a new data.set


# 3. Use descriptive activity names to name the activities in the data set
activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
activity_labels <- activity_labels[,2] # The names are stored in the 2nd column
relevant_data[,2] <- activity_labels[relevant_data[,2]] # change the values in the second column of the relevant_data data.set according to the names in the activity_labels vector


# 4. Appropriately labels the data set with descriptive variable names.
# The data has already been labeled in 1.


# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr) # load the dplyr package
tidy_data <- relevant_data %>% group_by(subject, activity) %>% summarise_each(funs(mean)) # group the data by "subject" and "activity" and run the mean function on all other columns; store results in new data.frame


