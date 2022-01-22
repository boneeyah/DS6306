olddata_wide <- read.table(header =TRUE, text = '
                          subject genderage Control Treatment1 Treatment2
                          1 32_M 7.9 12.3 10.7
                          2 45_F 6.3 10.6 11.1
                          3 27_F 9.5 13.1 13.8
                          4 23_M 11.5 13.4 12.9
                          ', colClasses = c("subject" = "factor"))
olddata_wide$subject <- factor(olddata_wide$subject)
summary(olddata_wide)
?read.table

#change to longform
library(tidyr)
data_long <-
  gather(olddata_wide,
         condition,
         measurement,
         Control:Treatment2,
         factor_key = TRUE)
data_long
olddata_wide
data_long2 <-
  olddata_wide %>% pivot_longer(
    c(Control:Treatment2),
    names_to = "condition",
    values_to = "measurement",
    names_transform = list(condition = as.factor)
  )

data_long2
orig_data <-
  data_long2 %>% pivot_wider(names_from = condition, values_from = measurement)
orig_data
? spread
install.packages("XML")
library(XML)
library(xml)



