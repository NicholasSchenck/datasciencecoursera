#####

# run_Analysis.R will:
# * Download the file 
# * Load tables
# * Merges the training and the test sets to create one data set.
# * Extracts only the measurements on the mean and standard deviation for each measurement. 
# * Uses descriptive activity names to name the activities in the data set
# * Appropriately labels the data set with descriptive variable names. 
# * From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Download the dataset:

zipname <- "getdata_dataset.zip"
if (!file.exists(zipname)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, zipname, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(zipname) 
}

# read tables 
activity = read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE)
subjecttest = read.table('UCI HAR Dataset/test/subject_test.txt',header=FALSE); 
xtest = read.table('UCI HAR Dataset/test/x_test.txt',header=FALSE);
ytest = read.table('UCI HAR Dataset/test/y_test.txt',header=FALSE); 
features = read.table("UCI HAR Dataset/features.txt",header=FALSE)
xtrain = read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
ytrain = read.table("UCI HAR Dataset/train/Y_train.txt",header=FALSE)
subjectrain = read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# Assigin labels names to the tables
colnames(activity)= c('activityId','activityType');
colnames(xtrain)= features[,2]; 
colnames(subjectrain)= "subjectId";
colnames(ytrain)= "activityId";
colnames(subjecttest) = "subjectId";
colnames(xtest) = features[,2]; 
colnames(ytest) = "activityId";

#column bind the tables 
trainingData = cbind(ytrain,subjectrain,xtrain);
testData = cbind(ytest,subjecttest,xtest);

#Merge the test and training data sets
mergedDataset <-rbind(trainingData,testData)

# Return collumn means 
meansDataset<- colMeans(mergedDataset)

#write to table
write.table(meansDataset, "meansdata.txt", sep="\t")


