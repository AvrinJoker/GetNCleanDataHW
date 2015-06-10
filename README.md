# GetNCleanDataHW
There are basically five parts of the code.

## 1. Merge the data from teat and train set
By using `read.table()` and `rbind()`, the test data is attached after train data: 
(1) merge subject_* files (subject/participant number from 1-30) into **person_id**
```r
test_id = read.table("./UCI HAR Dataset/test/subject_test.txt")
train_id = read.table("./UCI HAR Dataset/train/subject_train.txt")
person_id = rbind(train_id,test_id)
```
(2) merge y_* files (activity number from 1-6) into **activity**
```r
test_activity = read.table("./UCI HAR Dataset/test/y_test.txt")
train_activity = read.table("./UCI HAR Dataset/train/y_train.txt")
activity = rbind(train_activity,test_activity)
```
(3) merge X_* files (all the parameters measured in the experiment) into **data_set** 
```r
test_set = read.table("./UCI HAR Dataset/test/X_test.txt")
train_set = read.table("./UCI HAR Dataset/train/X_train.txt")
data_set = rbind(train_set,test_set)
```
## 2. Extracts only the measurements on the mean and standard deviation for each measurement
(1) read the label file and find the columns with mean or sd and use `grep()` to extract the column index range
```r
label = read.table("./UCI HAR Dataset/features.txt")[,2]
label_range = grep("-mean\\(\\)|-std\\(\\)",label)
```
(2) use the index range to extract experimental data from **data_set** into **subLib**
```r
subLib = data_set[,label_range]
```
(3) merge all the data with `cbind()` with seperated columns into **allLib** and add proper labels to them
```r
allLib = cbind(person_id, activity, subLib)
names(allLib) = c("subject","activity",tolower(as.character(label[label_range])))
```
## 3. Uses descriptive activity names to name the activities in the data set
replace the activity number(1-6) in *activity* column with corresponding activity names(walking etc)
```r
actLib = c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying")
for (i in 1:6){
    allLib$activity[allLib$activity==i] <-actLib[i]
    }
```
## 4. Appropriately labels the data set with descriptive variable names 
(1) set a list of the elements that presented in the original column labels, and another set of the replacement
```r
ori_nameLib = c("-","^t","^f","body","gravity","acc","jerk","gyro","mag","mean","std","\\(|\\)","\\_$")
rpl_nameLib = c("","time_","frequency_","body_","gravity_","acceleration_","jerk_","gyroscope_",
                "magnitude_","mean_","std_","","")
```
(2) replace along the list using `gsub()`
```r
for (i in 1:length(ori_nameLib)) {
    names(allLib) <- gsub(ori_nameLib[i],rpl_nameLib[i],names(allLib))
    }
```
(3) save the data in **merged.txt**
write.table(averLib,"./averaged.txt", row.names = F)
## 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
(1) use `aggregate()` to calculate the mean in each column with particular subeject(1-30) and activity(6 kind)
averLib = aggregate(x=allLib, by=list(activities=allLib$activity, subjects=allLib$subject), FUN=mean)
averLib = averLib[, !(colnames(averLib) %in% c("subject", "activity"))]
(2) save the data in **tidy_data.txt**
write.table(averLib,"./tidy_data.txt", row.names = F)
