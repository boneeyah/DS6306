library(XML)
library(RCurl)
?getURL
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
call1 <- GET(fileURL)
call1_text <- content(call1, "text")
doc <- xmlTreeParse(fileURL, useInternalNodes = TRUE)


doc <- htmlTreeParse(fileURL, useInternalNodes = TRUE)
call1_text
doc2 <- xmlTreeParse(doc, useInternalNodes = TRUE)
doc2
doc
?xmlTreeParse
doc <- xmlTreeParse(call1_text)
doc
call1_text
