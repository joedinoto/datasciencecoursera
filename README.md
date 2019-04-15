## Getting And Cleaning Data week 3 final project

The run_analysis.R script is broken into six sections. 

# 0. Download and unzip the .zip into the working directory, set libraries, and explore the dimensions of the files. 

Now the actual assignment can begin.

# 1. Merge the training and the test sets to create one data set. 

The features & activities in /UCI Har Dataset have dimensions of 561x2 and 6x2 respectively. The smallest data set (activities) is code 1 = walking, 2 = walkingupstairs, etc... so that will be dealt with later. 

The X_train, y_train, and subject_train in /UCI Har Dataset/train have dimensions of 7352x561, 7352x1, and 7352x1 respectively.

The X_test, y_test, and subject_test in /UCI Har Dataset/test have dimensions of 2947x561, 2947x1, and 2947x1 respectively. 

It's pretty clear that the rows of x_test, y_test, and subject_test (as well as the rows of their respective _train counterparts) must be put together using rbind() and when that is done we have one master_bound tibble with staggering dimension: 10,299 x 563.

Now we can begin work on part 2. 

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

