# download data
url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest <- "data.zip"
download.file(url,dest,method="curl")

# unzipping data
unzip("data.zip")

# set working directory
setwd("./UCI Har Dataset")

# set packages
library()