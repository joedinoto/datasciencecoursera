if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv",method="curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)

tolower(names(cameraData))

splitNames = strsplit(names(cameraData),"\\.")
splitNames[[6]]
splitNames

mylist <- list(letters=c("A","b","c"),numbers =1:3, matrix(1:25,ncol=5))
head(mylist)

mylist[1]

mylist$letters

mylist[[1]]

splitNames[[6]][1]

# Remove periods from variable names location.1 --> location
firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)


fileUrl1 <- "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/reviews.csv"
fileUrl2 <- "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/solutions.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)

names(reviews)

sub("_","",names(reviews))

# sub() only replaces first instance in a string
# gsub() will replace all instances in a string
testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName)
testName

grep("Alameda",cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]
head(cameraData2)

grep("Alameda",cameraData$intersection,value = TRUE)
grep("JeffStreet",cameraData$intersection)
length(grep("JeffStreet",cameraData$intersection))

# Useful library for string manipulation 
library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek",1,7)
paste("Jeffrey", "Leek")
paste0("Jeffrey","Leek") # pastes without space
str_trim("Jeff     ")  # Trims trailing spaces with stringr 

