# Coursera "Getting and Cleaning Data" Project

The goal of this project was to  prepare tidy data that can be used for later analysis from accelerometer measurements taken by a Samsung Galaxy S smartphone.

The script run_analysis.R retrieves the accelerometer data and data labels, and summarizes it by producing a file tidyData.txt.  TidyData.txt contains an average of every mean and standard deviation of a particular accelerometer parameter reading, for each one of the 30 subjects, and for each one of the 6 activities.

Resulting data set tidyData.txt is 180 lines (30 subjects * 6 activities) and contains 2 columns of identifying data (Subject ID and name of activity), along with 66 columns of data.

### The run_analysis.R script:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Labels the data set with descriptive variable names.
4. Assigns descriptive activity names to name the activities in the data set
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.