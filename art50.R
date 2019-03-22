# Revoke Article 50 and remain in the EU.
# Produces a table of countries with >10k signatures
# and a table of the top 6 MPs with the most signatures in their region

library(jsonlite)
jsonData <- fromJSON("https://petition.parliament.uk/petitions/241584.json")
DownloadTime <- date()
#str(jsonData) # Tells us the structure of the data

# to create a table of signature counts by country
# and restrict it to countries with more than 1,000 signatures

x<- jsonData$data$attributes$signatures_by_country$signature_count
y<- jsonData$data$attributes$signatures_by_country$name
my_data<- as.data.frame(cbind(y,x))
my_data[x>1000,]
mp<- jsonData$data$attributes$signatures_by_constituency$mp
mp_number <- jsonData$data$attributes$signatures_by_constituency$signature_count
mp_table <- as.data.frame(cbind(mp,mp_number))
head(mp_table[order(-mp_number),]) #the negative means descending
DownloadTime
