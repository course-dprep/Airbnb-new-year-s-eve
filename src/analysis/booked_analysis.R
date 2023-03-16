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

##complete model booked: logistic regression
model_booked <- glm(booked ~ newyearseve, data = complete_data, family = binomial)
summary(model_booked)

##Model per city booked: logistic regression
#Loop through each city and generate the model and summary for booked (logistic regression)
models_booked <- lapply(cities, function(city) {
  model_booked <- glm(booked ~ newyearseve, family = binomial, data = get(paste0("complete_data_", city)))
  cat("Summary for", toupper(city), "\n")
  print(summary(model_booked))
  return(list(city=city, model_booked=model_booked))
})



