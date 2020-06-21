x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")

y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("Code", "Activity")
feature_labels <- read.table("UCI HAR Dataset/features.txt")[,2]

# Merges the training and the test sets to create one data set.
x_data <- rbind(x_train, x_test)
names(x_data) <- feature_labels

y_data <- rbind(y_train, y_test)
names(y_data) <- "Activity"

subject_data <- rbind(subject_train, subject_test)
names(subject_data) <- "Subject"

# Extracts only the measurements on the mean and standard deviation for each measurement.
all <- cbind(subject_data, y_data, x_data)
mean_data <- all[, grepl("mean", names(all), ignore.case = TRUE)]
sd_data <- all[, grepl("std", names(all), ignore.case = TRUE)]

# Uses descriptive activity names to name the activities in the data set
all_updated <- cbind(subject_data, y_data, mean_data, sd_data)
all_updated$Activity <- activity_labels[all_updated$Activity, 2]
all_updated$Activity <- as.factor(all_updated$Activity)

# Appropriately labels the data set with descriptive variable names.
names(all_updated) <- gsub("Acc", "Accelerometer", names(all_updated))
names(all_updated)<-gsub("Gyro", "Gyroscope", names(all_updated))
names(all_updated)<-gsub("BodyBody", "Body", names(all_updated))
names(all_updated)<-gsub("Mag", "Magnitude", names(all_updated)
names(all_updated)<-gsub("^t", "Time", names(all_updated))
names(all_updated)<-gsub("^f", "Frequency", names(all_updated))
names(all_updated)<-gsub("tBody", "TimeBody", names(all_updated))
names(all_updated)<-gsub("-mean()", "Mean", names(all_updated), ignore.case = TRUE)
names(all_updated)<-gsub("-std()", "STD", names(all_updated), ignore.case = TRUE)
names(all_updated)<-gsub("-freq()", "Frequency", names(all_updated), ignore.case = TRUE)
names(all_updated)<-gsub("angle", "Angle", names(all_updated))
names(all_updated)<-gsub("gravity", "Gravity", names(all_updated))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
final <- group_by(all_updated, Subject, Activity)
final_data <- summarise_all(final, funs(mean))
write.table(final_data, "final_data.txt")
