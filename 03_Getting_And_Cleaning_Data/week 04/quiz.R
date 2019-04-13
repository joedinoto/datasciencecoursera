### My solutions to the quiz for my own reference purposes

## QUESTION 1
## "" "15"

# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list?

# Download the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile="./data/IDhousing.csv",method="curl")
IDhousing <- read.csv("./data/IDhousing.csv")
names(IDhousing)

#isolate wgtp
wgtp <- IDhousing$WGTP
wgtp

# answer the damned question
IDlist<- strsplit(names(IDhousing),split="wgtp")
IDlist[123]

## QUESTION 2
## 377652.4

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table

library(data.table)

# Download the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile="./data/GDP.csv",method="curl")
GDP <- data.table::fread("./data/GDP.csv",skip=5,nrows=190,select = c(1, 2, 4, 5), col.names=c("CountryCode", "Rank", "Economy", "Total"))
names(GDP)
library(dplyr)
library(tidyr)
GDP<- as_tibble(GDP)
GDP
GDP<- mutate(GDP,millions=as.numeric(gsub(",","",GDP$Total)))
millions<- GDP$millions
millions<- as.data.frame(millions)
millions
colMeans(millions)


## Question 3
## length(grep("^United",GDP$CountryCode))

# In the data set from Question 2 what is a regular expression that would 
# allow you to count the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United?

length(grep("^United",GDP$CountryCode))

## Quesion 4
## 13

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. Of the countries for which the end of 
# the fiscal year is available, how many end in June?
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats

# Download the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl,destfile="./data/EDU.csv",method="curl")
EDU <- as_tibble(data.table::fread("./data/EDU.csv"))
names(EDU)

mergedtibble<- tibble(merge(EDU,GDP,'CountryCode'))

> fiscal<- grep("end: June",merged$`Special Notes`)


## Question 5
## 250, 47

install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
only2012<- grep("012",sampleTimes)
wk<- weekdays(just2012, abbreviate = F)
justMon<- grep("Mon",wk)
length(justMon)
