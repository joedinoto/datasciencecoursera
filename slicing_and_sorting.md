# Key skills learned in week 1

## Reading and learning about a `.csv` file

Load the file into memory as a variable `x`.
````
x <- read.csv("hw1_data.csv")
````
Preview the first few lines 
````
head(x)
````
Find out how many `NA` values there are in each column
````
colSums(is.na(x))
````
Remove the rows with `NA` values and create a new table `good` which only contains rows without `NA` values. 
````
xgood <- complete.cases(x)
x[xgood,]
````
Two useful commans for finding the sum or means of the columns. 
````
colSums(xgood)
colMeans(xgood)
````
Say you only wanted the rows where the Wind was greater than 80. 
````
xgood["Wind">80]
````
Or where the Wind was greater than 80 and the month was exactly 4. 
````
xgood["Wind">80 & "Month"==4] ## Two equal signs are needed, using only one gives an error
````
Or something similar
````
windysept <-xgood[xgood$Month==9 & xgood$Wind>10,]
````
Sorting is yet to come.
