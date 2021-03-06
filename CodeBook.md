---
title: "CodeBook.md"
author: ""
date: "6/21/2020"
output: md_document
---



The run_analysis.R script performs the data preparation by following the steps shown below:

## 1. Download the dataset

- Dataset downloaded and extracted under the folder called UCI HAR Dataset

## 2. Assign each data to variables
- x_train <- X_train.txt: 7352 obs. of 561 variables (contains recorded features on the train data)
- x_test <- X_test.txt: 2947 obs. of 561 variables (contains recorded features on the test data)
- y_train <- Y_train.txt: 7352 obs. of 1 variable (contains activities' code labels of train data)
- y_test <- Y_test.txt: 2947 obs. of 1 variable (contains activities' code labels of test data)
- subject_train <- subject_train.txt: 7352 obs. of 1 variable (contains train data of 21/30 volunteer subjects being observed)
- subject_test <- subject_test.txt: 2947 obs. of 1 variable (contains test data of 9/30 volunteer test subjects being observed)
- activty_labels <- activity_labels.txt: 6 obs. of 2 variables (List of activities performed when the corresponding measurements were taken and its codes (labels))
- feature_labels <- features.txt : 561 obs. of 2 variables (the features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ)

## 3. Merges the training and the test sets to create one data set
- x_data is created by using the rbind() function to merge x_train and x_test (10299 obs. of 561 variables)
- y_data is created by using the rbind() function to merge y_train and y_test (10299 obs. of 1 variable)
- subject_data is created by using the rbind() function to merge subject_train and subject_test (10299 obs.of 1 variable)
- all is created by using the cbind() function to merge x_data, y_data, and subject_data (10299 obs. of 563 variables)

## 4. Extracts only the measurements on the mean and standard deviation for each measurement
- all_updated is created by using grepl to first extract the columns in all that have mean or standard deviation in them and then using the cbind() function to merge subject_data, y_data, mean_data, sd_data

## 5. Uses descriptive activity names to name the activities in the data set
- Entire numbers in code column of all_updated replaced with corresponding activity taken from second column of the activities_label variable

## 6. Appropriately labels the data set with descriptive variable names
- All Acc in column’s name replaced by Accelerometer
- All Gyro in column’s name replaced by Gyroscope
- All BodyBody in column’s name replaced by Body
- All Mag in column’s name replaced by Magnitude
- All start with character f in column’s name replaced by Frequency
- All start with character t in column’s name replaced by Time

## 7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
- final is created by grouping all_updated by subject and activity and then applying the mean function of each variable
