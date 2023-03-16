library(broom)
library(tidyr)
library(ggplot2)
library(readr)
library(data.table)
library(dplyr)
library(tidyverse)
library(stargazer)

##INPUT##
#import the complete data 
complete_data <- read_csv("../../gen/data-preparation/output/complete_data.csv")

#import the data per cities
cities <- c("rome", "paris", "ams", "london")

for (city in cities) {
  file_name <- paste0("complete_data_", city, ".csv")
  assign(paste0("complete_data_", city), read_csv((paste0("../../gen/data-preparation/output/", "complete_data_",city, ".csv"))))
}

##TRANSFORMATION##
#complete model price: linear regression 
model_price <- lm(price ~ newyearseve, data = complete_data)
summary(model_price)


#Model per city price: linear regression
# Loop through each city and generate the model and summary for price
models_price <- lapply(cities, function(city) {
  model_price <- lm(price ~ newyearseve, data = get(paste0("complete_data_", city)))
  cat("Summary for", toupper(city), "\n")
  print(summary(model_price))
  return(list(city=city, model_price=model_price))
})

#model where differences in prices are shown per city compared to london
model_price_city_differences <- lm(price ~ newyearseve + paris_dum + rome_dum + ams_dum, data = complete_data)
summary(model_price_city_differences)

##OUTPUT##
save(model_booked, model_price, models_price, models_booked, model_price_city_differences, file='../../gen/analysis/output/model_results.RData') 

