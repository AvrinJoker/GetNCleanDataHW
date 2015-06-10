library(data.table)

## merge the data from test and training set
# merge personal ID (1-30)
test_id = read.table("./UCI HAR Dataset/test/subject_test.txt")
train_id = read.table("./UCI HAR Dataset/train/subject_train.txt")
person_id = rbind(train_id,test_id)
# merge activity (1-6) people take
test_activity = read.table("./UCI HAR Dataset/test/y_test.txt")
train_activity = read.table("./UCI HAR Dataset/train/y_train.txt")
activity = rbind(train_activity,test_activity)
# read activity data with mean and sd and add corresponding label 
test_set = read.table("./UCI HAR Dataset/test/X_test.txt")
train_set = read.table("./UCI HAR Dataset/train/X_train.txt")
data_set = rbind(train_set,test_set)


## Extracts only the measurements on the mean and standard deviation for each measurement
# read the label and find the range to extract mean/sd
label = read.table("./UCI HAR Dataset/features.txt")[,2]
label_range = grep("-mean\\(\\)|-std\\(\\)",label)
# extract data from data_set
subLib = data_set[,label_range]
# merge all
allLib = cbind(person_id, activity, subLib)
# relabel
names(allLib) = c("subject","activity",tolower(as.character(label[label_range])))


## Uses descriptive activity names to name the activities in the data set
actLib = c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying")
for (i in 1:6){allLib$activity[allLib$activity==i] <-actLib[i]}


## Appropriately labels the data set with descriptive variable names 
# original names
ori_nameLib = c("-","^t","^f","body","gravity","acc","jerk","gyro","mag","mean","std","\\(|\\)","\\_$")
# replacement
rpl_nameLib = c("","time_","frequency_","body_","gravity_","acceleration_","jerk_","gyroscope_",
                "magnitude_","mean_","std_","","")
# replace along the list
for (i in 1:13) {names(allLib) <- gsub(ori_nameLib[i],rpl_nameLib[i],names(allLib))}
write.table(allLib, './merged.txt', row.names = F)

## creates a second, independent tidy data set with the average of each variable for 
## each activity and each subject.
averLib = aggregate(x=allLib, by=list(activities=allLib$activity, subjects=allLib$subject), FUN=mean)
averLib = averLib[, !(colnames(averLib) %in% c("subject", "activity"))]
write.table(averLib,"./averaged.txt", row.names = F)

