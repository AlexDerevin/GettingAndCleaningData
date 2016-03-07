#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#If data does not exist, download and unpack the data, then and set working directory
library(reshape2)
directoryName <- "UCI HAR Dataset"
fileName <- "UCI HAR Dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(directoryName)) {
  download.file(fileURL, destfile = fileName)
  unzip(fileName, overwrite = TRUE)
}
  setwd(directoryName)

#load features and labels
activityLabels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)

names <- read.table("features.txt", stringsAsFactors = FALSE)[,2]

#load data
test <- read.table("./test/X_test.txt")
train <- read.table("./train/X_train.txt")

testLabels <- read.table("./test/y_test.txt")
trainLabels <- read.table("./train/y_train.txt")

testSubjects <- read.table("./test/subject_test.txt")
trainSubjects <- read.table("./train/subject_train.txt")



#Extract only columns with mean and standard deviation of each measurement
colsWanted <- (intersect(grep("mean|std",names),grep("meanFreq",names,invert=TRUE)))
test <- test[,colsWanted]
train <- train[,colsWanted]
names <- names[colsWanted]

#Add subject and activity labels to data
test<- cbind(testSubjects, testLabels, test)
train <- cbind(trainSubjects, trainLabels, train)

#Merge train and test data, label combined data set with variable (column) names.
combinedData <- rbind(test, train)
colnames(combinedData) <- c("Subject", "Activity", names)

#Convert Activity column from activity ID's 1-6 to descriptive activity names
combinedData$Activity<-as.factor(combinedData$Activity)
levels(combinedData[,2])<- activityLabels[,2]


#Create a second tidy data set with an average of each variable for each subject/activity combination
mdata <- melt(combinedData, id.vars = c("Subject", "Activity"))
tidyData <- dcast(mdata, Subject + Activity ~ variable, fun.aggregate=mean)

#Return from whence we came and write tidy data set to disk
setwd("..")
write.table(tidyData, "tidyData.txt", row.names = FALSE, quote = FALSE)


return