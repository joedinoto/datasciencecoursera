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
dim(features) 
#[1] 561   2
activity_labels<- fread("activity_labels.txt")
dim(activity_labels)
#[1] 6 2

# /UCI Har Dataset/test
subject_test <- fread("./test/subject_test.txt",col.names = "subject")
dim(subject_test)
#[1] 2947    1
X_test <- fread("./test/X_test.txt")
dim(X_test)
#[1] 2947  561
y_test <- fread("./test/y_test.txt",col.names = "y")
dim(y_test)
#[1] 2947    1

# /UCI Har Dataset/train
subject_train <- fread("./train/subject_train.txt",col.names = "subject")
dim(subject_train)
#[1] 7352    1
X_train <- fread("./train/X_train.txt")
dim(X_train)
#[1] 7352  561
y_train <- fread("./train/y_train.txt",col.names="y")
dim(y_train)
#[1] 7352    1

# bind all the test data together, store result as tibble 2,947 x 563
test_bound<- cbind(y_test,X_test) %>% 
  cbind(subject_test,.) %>% 
  as_tibble()

# bind all the train data together, store result as tibble 7,352 x 563
train_bound<- cbind(y_train,X_train) %>% 
  cbind(subject_train,.) %>% 
  as_tibble()

# bind test & train data into master tibble 10,299 x 563
master_bound <- rbind(test_bound,train_bound) %>% as_tibble()
