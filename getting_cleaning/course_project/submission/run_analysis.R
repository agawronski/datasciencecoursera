library(data.table)
# 1 Merge Test data
# set features as the variable names for x_test
features <- read.table(file="features.txt", header=FALSE)
x_test <- read.table(file="test/X_test.txt", header=FALSE)
names(x_test) <- features[,2]

y_test <- read.table(file="test/y_test.txt", header=FALSE) 
names(y_test) <- "labels" # to be replaced with activity labels

#column bind the "test Labels" to the "Test Set" 
test_df <- cbind(y_test, x_test)
#column bind the subject id 
subject_id <- read.table(file="test/subject_test.txt", header=FALSE)
names(subject_id) <- "SubjectId"
test_df <- cbind(test_df, subject_id)

#merge test_df and the activity labels
activity_labels <- read.table(file="activity_labels.txt", header=FALSE)
#remove the underscore and make all lower case
activity_labels[,2] <- tolower(gsub("_", "", activity_labels[,2]))
#capitalize the first letter of upstairs for readability 
substr(activity_labels[2,2], 8,8) <- toupper(substr(activity_labels[2,2], 8,8))
#capitalize the first letter of downstairs for readability 
substr(activity_labels[3,2], 8,8) <- toupper(substr(activity_labels[3,2], 8,8))

test_df <- merge(test_df, activity_labels, by.x="labels", by.y="V1", all=TRUE)
colnames(test_df)[564] <- "activity" #rename new activty column



#Repeat the process with the training set

# 1 Merge Training data
# set features as the variable names for x_train
features <- read.table(file="features.txt", header=FALSE)
x_train <- read.table(file="train/X_train.txt", header=FALSE)
names(x_train) <- features[,2]

y_train <- read.table(file="train/y_train.txt", header=FALSE) 
names(y_train) <- "labels" # to be replaced with activity labels

#column bind the "Training Labels" to the "Training Set" 
train_df <- cbind(y_train, x_train)

#column bind the subject id 
subject_id <- read.table(file="train/subject_train.txt", header=FALSE)
names(subject_id) <- "SubjectId"
train_df <- cbind(train_df, subject_id)

#merge train_df and the activity labels
activity_labels <- read.table(file="activity_labels.txt", header=FALSE)
#remove the underscore and make all lower case
activity_labels[,2] <- tolower(gsub("_", "", activity_labels[,2]))
#capitalize the first letter of upstairs for readability 
substr(activity_labels[2,2], 8,8) <- toupper(substr(activity_labels[2,2], 8,8))
#capitalize the first letter of downstairs for readability 
substr(activity_labels[3,2], 8,8) <- toupper(substr(activity_labels[3,2], 8,8))

train_df <- merge(train_df, activity_labels, by.x="labels", by.y="V1", all=TRUE)
colnames(train_df)[564] <- "activity" #rename new activty column


#Combine the test and training sets
library(dplyr)
test_df <- tbl_df(test_df)
train_df <- tbl_df(train_df)
data_set <- rbind(train_df, test_df)

# select only measurements on mean and standard deviation and remove the angle measurement
data_set <- data_set %>%
  select(SubjectId, activity, contains("mean"), contains("std"), -contains("angle"))

#remove the function parenthesis
names(data_set) <- gsub("\\()", "", names(data_set))
#remove the time indicator as the f (FFT) indicator is enough of a differentiator
names(data_set) <- sub("^t", "", names(data_set))
#eliminate the double body (?typo)
names(data_set) <- sub("BodyBody", "Body", names(data_set))
#Change mean to Mean for readability
names(data_set) <- sub("mean", "Mean", names(data_set))
#Remove -
names(data_set) <- gsub("-", "", names(data_set))
#Replace std with Std for readability
names(data_set) <- gsub("std", "Std", names(data_set))

#average each variable for each activity and each subject
grouped_set <- group_by(data_set, activity, SubjectId)
final_set <- summarise_each(grouped_set, "mean")

#write the table into the working directory as final_set.txt
write.table(final_set, file="final_set.txt", row.names=FALSE)

#take a look at the tidy data set
View(final_set)
