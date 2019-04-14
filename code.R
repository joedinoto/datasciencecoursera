# Preliminaries: downloading data, setting working directory, exploring dimensions of data

# download data
url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest <- "data.zip"
download.file(url,dest,method="curl")

# unzip data
unzip("data.zip")

# set working directory
setwd("./UCI Har Dataset")

# set packages
# https://www.rstudio.com/resources/cheatsheets/ to learn more
library(data.table)
library(dplyr)
library(tidyr)

# /UCI Har Dataset 
# read and obtain dimensions of features.txt and activity_labels.txt
features<- fread("features.txt")
dim(features)         #[1] 561   2
activity_labels<- fread("activity_labels.txt")
dim(activity_labels)  #[1] 6 2

# /UCI Har Dataset/test
subject_test <- fread("./test/subject_test.txt",col.names = "subject")
dim(subject_test)     #[1] 2947    1
X_test <- fread("./test/X_test.txt")
dim(X_test)           #[1] 2947  561
y_test <- fread("./test/y_test.txt",col.names = "activity")
dim(y_test)           #[1] 2947    1

# /UCI Har Dataset/train
subject_train <- fread("./train/subject_train.txt",col.names = "subject")
dim(subject_train)    #[1] 7352    1
X_train <- fread("./train/X_train.txt")
dim(X_train)          #[1] 7352  561
y_train <- fread("./train/y_train.txt",col.names="activity")
dim(y_train)          #[1] 7352    1


# bind all the test data together, store result as tibble 2,947 x 563
test_bound<- cbind(y_test,X_test) %>% 
  cbind(subject_test,.) %>% 
  as_tibble()

# bind all the train data together, store result as tibble 7,352 x 563
train_bound<- cbind(y_train,X_train) %>% 
  cbind(subject_train,.) %>% 
  as_tibble()

# Step 1 of instructions are satisfied
# 1. Merges the training and the test sets to create one data set.

# bind test & train data into master tibble 10,299 x 563
master_bound <- rbind(test_bound,train_bound) %>% 
  as_tibble()

# put away the first 2 columns of master_bound for later
master_bound_first_two <- select(master_bound,c(subject,activity))
dim(master_bound_first_two)

# replace 1...6 with walking ... laying
# there's got to be a better way
master_bound_first_two<- sub(1,"Walking",master_bound_first_two$activity) %>% 
  sub(2,"WalkingUpStairs",.) %>%
  sub(3,"WalkingDownstairs",.) %>%
  sub(4,"Sitting",.) %>%
  sub(5,"Standing",.) %>%
  sub(6,"Laying",.) %>% 
  as_tibble()

# just the first column of master_bound
master_bound_subject<- select(master_bound,subject)

# binding together the 1st col of master_bound w/descriptive names (walking... laying)
master_bound_first_two <- cbind(master_bound_subject,master_bound_first_two)
dim(master_bound_first_two) #[1] 10299     2
head(master_bound_first_two)

# Find features that contain "mean()" and "std()"
mean <- filter(features, grepl("std\\(",V2))
std <- filter(features, grepl("mean\\(",V2))

# Step 2 of the instructions are satisfied
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# combine "mean()" and "std()" into a single tibble
mean_and_std <- rbind(mean,std) %>% as_tibble()
dim(mean_and_std) #[1] 66  2

# Create a third column in the features table that will be used 
# to select columns in the master_bound table

# creates third column mean_vector with entries V1, V2, etc.
mean_and_std <- mutate(mean_and_std,mean_and_std_vector=paste("V",mean_and_std$V1,sep="")) 
dim(mean_and_std) #[1] 66  3

# selects only V1, V2, ... V41, V42, etc. that contain "mean()" or "std()"
master_bound_filtered<- select(master_bound,mean_and_std$mean_and_std_vector)
dim(master_bound_filtered) #[1] 10299    66

# Steps 3 & 4 of the instructions are satisfied
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.

# renames the column headers to tbodyacc, tgravityacc...etc.  
master_bound_filtered_named<- setnames(master_bound_filtered,old=mean_and_std$mean_and_std_vector,new=mean_and_std$V2)
names(master_bound_filtered_named)
dim(master_bound_filtered_named) #[1] 10299    66 but it should be 10299    68...

# add back the subject and y columns
master_bound_filtered_named<- cbind(master_bound_first_two,master_bound_filtered_named) %>% 
  as_tibble()
dim(master_bound_filtered_named) #[1] 10299    68

# write master_bound_filtered_named to .csv for easier exploration
write.csv(master_bound_filtered_named,"master_bound_filtered_named.csv")


# 5.From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
# What are the variables, activities, and subjects?