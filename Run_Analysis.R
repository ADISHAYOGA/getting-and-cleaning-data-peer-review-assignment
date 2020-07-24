## Changing my directory to the appropriate location
> dir()

[1] "activity_labels.txt" "features.txt"        "features_info.txt"  
[4] "README.txt"          "test"                "train"

## Reading data descriptions and activity labels              
> features <- read.table("features.txt")
> activity_labels <- read.table("activity_labels.txt") 
> setwd("./test")
> dir()
[1] "Inertial Signals" "subject_test.txt" "X_test.txt"       "y_test.txt"      

## Reading Test data.
> x_test   <- read.table("X_test.txt")
> y_test   <- read.table("Y_test.txt")
> sub_test <- read.table("subject_test.txt")

## Reading Train data
> x_train   <- read.table("X_train.txt")
> y_train   <- read.table("Y_train.txt")
> sub_train <- read.table("subject_train.txt")

## 1. Merges the training and the test sets to create one data set.
> x_total   <- rbind(x_train, x_test)
> y_total   <- rbind(y_train, y_test)
> sub_total <- rbind(sub_train, sub_test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> selcols <- features[grep(".*mean\\(\\)|std\\(\\)", features[,2]),]
> X_total <- x_total[,selcols[,1]]


## 3. Uses descriptive activity names to name the activities in the data set
>colnames(y_total) <- "activity_labels"
> colnames(y_total) <- "activity_labels"
> y_total$activitylabel <- factor(y_total$activity, labels = as.character(activity_labels[,2]))
> activitylabel <- y_total[,-1]

## 4. Appropriately labels the data set with descriptive variable names.
> colnames(x_total) <- features[selcols[,1],2]


## 5. From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
> colnames(sub_total) <- "subject"
> total <- cbind(x_total, activitylabel, sub_total)
>total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))

## 6. Writing a separate new file with desired columns.
>write.table(total_mean, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)


