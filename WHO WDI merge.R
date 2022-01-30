library(WDI)
library(dplyr)
library(httr)
library(countrycode)
library(plotly)
library(ggplot2)

GDPPC <- WDI(indicator = "NY.GDP.PCAP.KD", start =2015, end=2015)

LE <- read.csv('/home/migue/Documents/data.csv')
LE$iso2c <- countrycode(LE$Location, 'country.name', 'iso2c')

LE2 <- LE %>% filter(IndicatorCode == "WHOSIS_000002",Dim1 == "Both sexes"& Period == 2015)
GDPPC2 <- GDPPC[50:266,]
GDPPC3 <- GDPPC2[!is.na(GDPPC2$NY.GDP.PCAP.KD),]

GDPPC_LE <- left_join(LE2,GDPPC3,"iso2c") %>% select(Location,NY.GDP.PCAP.KD,Value,Period)
head(GDPPC_LE)

names(GDPPC_LE)[1] <- "Country"

p <- GDPPC_LE %>% ggplot(aes(NY.GDP.PCAP.KD, Value, color = Country))+
  geom_point()
ggplotly(p)

