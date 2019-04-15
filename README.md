# Getting And Cleaning Data week 3 final project

The run_analysis.R script is broken into six sections. 
See the fully annoted code here: https://github.com/joedinoto/datasciencecoursera/blob/master/run_analysis.R
Read below for an overview about how the analysis was performed.

## 0. Download and unzip the .zip into the working directory, set libraries, and explore the dimensions of the files. 

First is is code that downloads the data in .zip format, unzips it, sets up relevant libraries that R will use ,then explores the dimension of the files that are unzipped. From there, the actual assignment can begin.

## 1. Merge the training and the test sets to create one data set. 

The features & activities in /UCI Har Dataset have dimensions of 561x2 and 6x2 respectively. The smallest data set (activities) is code 1 = walking, 2 = walkingupstairs, etc... so that will be dealt with later. 

The X_train, y_train, and subject_train in /UCI Har Dataset/train have dimensions of 7352x561, 7352x1, and 7352x1 respectively.

The X_test, y_test, and subject_test in /UCI Har Dataset/test have dimensions of 2947x561, 2947x1, and 2947x1 respectively. 

It's pretty clear that the rows of x_test, y_test, and subject_test (as well as the rows of their respective _train counterparts) must be put together using rbind() and when that is done we have one master_bound tibble with staggering dimension: 10,299 x 563.

Now we can begin work on part 2. 

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

Use grepl() on features to search for "mean()" and "std()" but not "meanfreq()".
Also, some other work was done to pull out the first two columns of the master_bound tibble and associate 1,2,...,6 with walking, walkingupstairs,....,laying. Those were then later put back into the masster_bound tibble. 

## 3. Uses descriptive activity names to name the activities in the data set

This was accomplished by renaming the values 1 through 6 with "walking"" through "laying". Mutate was also used to create a new column in mean_and_std that consisted of Vn such that n corresponded to the row number containng std() or mean(). That new column was used to re-name the columns of master_bound and create master_bound_filtered. 

## 4. Appropriately labels the data set with descriptive variable names.

master_bound_filtered_named is the end result of joining the large data tables in the original data set, filtering only the desired columns, and naming all columns and rows appropriatley. 

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

From here, a lot of re-naming and dplyr and tidyr were used to take an expression like fBodyAcc-std()-X and split that up into time or frequency (f in this case), variable (BodyAcc), "math" (std()) and xyz (x). The resulting tibble is named longtable and is of dimension 679,734 x 7. Every column is a variable:"time or freqency" (t or f) "variable" (One of 13 BodyAcc, BodyAccJerk,BodyAccJerkMag,BodyAccMag,BodyBodyAccJerkMag,BodyBodyGyroJerkMag,BodyBodyGyroMag,BodyGyro,BodyGyroJerk,BodyGyroJerkMag,BodyGyroMag,Gravit-yAcc, or Gravit-yAccMag)  "subject" (1 through 6) "activity" (walking, walkingupstairs, ... , laying) "math" (mean or std) "XYZ" (x,y, or z) and "observ" (the actual numerical value associated with). So every row is a single obevation and every column is a single variable. 

A .csv and .txt file were created from the tidy data set longtable for further exploration. 