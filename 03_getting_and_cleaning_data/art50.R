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

##########
# output # 
##########

                       y       x
12             Australia    8074
13               Austria    1638
19               Belgium    3022
39                Canada    5201
55               Denmark    1635
70                France   26523
75               Germany   11747
77             Gibraltar    2727
78                Greece    1010
88             Hong Kong    1594
95               Ireland    5141
98                 Italy    3286
117           Luxembourg    1080
141          Netherlands    5562
143          New Zealand    2854
149               Norway    1038
160             Portugal    1628
175            Singapore    1160
184                Spain   14750
195               Sweden    2387
196          Switzerland    3536
215 United Arab Emirates    1233
216       United Kingdom 3371918
217        United States   12858

                        mp mp_number
126  Thangam Debbonaire MP     23087
294      Catherine West MP     19774
122      Caroline Lucas MP     17947
142     Daniel Zeichner MP     17866
262 Rt Hon Diane Abbott MP     17480
292 Rt Hon Keir Starmer MP     17389

[1] "Fri Mar 22 14:24:59 2019"
