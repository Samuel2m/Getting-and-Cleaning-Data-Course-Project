#Changing the directory to the location of the unzipped files
setwd("D:/Cours/Coursera/Process/Project/UCI HAR Dataset")

# 1. Merge the training and the test sets to create one data set.

# Read in the data from files, the first row is already data not title so header = FALSE
features <- read.table('./features.txt',header=FALSE) #importing features
activityType <- read.table('./activity_labels.txt',header=FALSE) #importing activity_labels
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE) #importing subject_train
xTrain <- read.table('./train/x_train.txt',header=FALSE) #importing x_train
yTrain <- read.table('./train/y_train.txt',header=FALSE) #importing y_train
subjectTest <- read.table('./test/subject_test.txt',header=FALSE) #importing subject_test
xTest <- read.table('./test/x_test.txt',header=FALSE) #importing x_test
yTest <- read.table('./test/y_test.txt',header=FALSE) #importing y_test

# Assiging column names
colnames(activityType) <- c('ActivityId','ActivityType')
colnames(subjectTrain) <- "SubjectId"
colnames(xTrain) <- features[,2] 
colnames(yTrain) <- "ActivityId"
colnames(subjectTest) <- "SubjectId"
colnames(xTest) <- features[,2]
colnames(yTest) <- "ActivityId"


#Creating the final data set by binding the tests and the trainings data sets
finalData <- rbind(cbind(yTrain,subjectTrain,xTrain), cbind(yTest,subjectTest,xTest))


# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

colNames  <- colnames(finalData)

# Create a logical vector that with TRUE values for the ID, mean() and stddev() columns, FALSE for otherwise
logVector <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames))

# Subset finalData table based on the logicalVector to keep only desired columns
finalData <- finalData[logVector==TRUE]


# 3. Use descriptive activity names to name the activities in the data set

# Merge the finalData set with the acitivityType table to include descriptive activity names
finalData <- merge(finalData, activityType,by='activityId',all.x=TRUE)


#4. Appropriately label the data set with descriptive activity names. 

# Updating colNames to include the new column names after the merging
colNames  <- colnames(finalData)

for (i in 1:length(colNames)) #using gsub to change the column names to a tidy form
{
  colNames[i] <- gsub("\\()","", colNames[i])
  colNames[i] <- gsub("-std$","StdDev", colNames[i])
  colNames[i] <- gsub("-mean","Mean", colNames[i])
  colNames[i] <- gsub("^(t)","time", colNames[i])
  colNames[i] <- gsub("^(f)","freq", colNames[i])
  colNames[i] <- gsub("([Gg]ravity)","Gravity", colNames[i])
  colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body", colNames[i])
  colNames[i] <- gsub("[Gg]yro","Gyro", colNames[i])
  colNames[i] <- gsub("AccMag","AccMagnitude", colNames[i])
  colNames[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] <- gsub("JerkMag","JerkMagnitude", colNames[i])
  colNames[i] <- gsub("GyroMag","GyroMagnitude", colNames[i])
}


# Updating the column names
colnames(finalData) <- colNames


# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create a new table without the activityType column
finalDataNoActivityType  <- finalData[,names(finalData) != 'activityType']

# Include just the mean of each variable for each activity and each subject
activitySubjectMean <- aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean)

# Merging the tidyData with activityType to include descriptive activity names and get the tidy data
tidyData <- merge(activitySubjectMean,activityType,by='activityId',all.x=TRUE)

# Save the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t')
