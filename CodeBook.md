#Getting and Cleaning Data Project


##Description

The scope of this project is to transform raw data into a tidy data set.

##Source Data

The full description of the data can be found at the UCI Machine Learning repository.
The data set can be found at the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


##Data Set Information

Information come from the UCI Machine learning repository:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Attribute Information

For each record in the dataset it is provided:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.


##Section 1. Merging the training and the test sets to create one data set

After setting the working repository, the following tables (txt files) are read with the read.table function:

features.txt
activity_labels.txt
subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt

Those tables are merged, then names are attributed to columns.

##Section 2. Extracting only the measurements on the mean and standard deviation for each measurement

Creation of a logical vector containing TRUE values for the ID, mean and standard deviation columns and FALSE values otherwise. This vector is used to keep the wanted columns.

Section 3. Using descriptive activity names to name the activities in the data set

Merge the data set obtained thus far with the activityType table to get the descriptive activity names


Section 4. Appropriately labeling the data set with descriptive variable names

Cleaning the column names thanks to the gsub function to obtain tidy names

Section 5. From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject

We only need the average of each variable for each activity and subject in the dataset
Then write down the tidy data set in the working directory?

