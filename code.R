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
subject_test <- fread("./test/subject_test.txt")
dim(subject_test)
#[1] 2947    1
X_test <- fread("./test/X_test.txt")
dim(X_test)
#[1] 2947  561
y_test <- fread("./test/y_test.txt")
dim(y_test)
#[1] 2947    1