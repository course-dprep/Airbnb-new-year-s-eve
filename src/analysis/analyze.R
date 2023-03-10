##INPUT
library(broom)
library(tidyr)
library(ggplot2)
library(readr)
library(data.table)
library(dplyr)
library(tidyverse)
library(stargazer)
#create directory 

dir.create('../../src/analysis/regression')

#import data 

cities <- c("rome", "paris", "ams", "london")

for (city in cities) {
  file_name <- paste0("complete_data_", city, ".csv")
  assign(paste0("complete_data_", city), read.csv(file_name))
}

#loop for view complete data
for (city in cities) {
  view(get(paste0("complete_data_", city)))
}

##TRANSFORMATION

#complete model booked 

model_booked <- lm(booked ~ newyearseve, data = complete_data)
summary(model_booked)

#complete model price 

model_price <- lm(price ~ newyearseve, data = complete_data)
summary(model_price)

##works until here for sure - hilal

#linear regression for booked per city
#need to make a loop of this: per city

# Loop through each city and generate the model and summary for booked
for (city in cities) {
  # Generate the model
  model <- lm(booked ~ newyearseve, data = get(paste0("complete_data_", city)))
  
  # Print the summary
  cat("Summary for", toupper(city), "\n")
  print(summary(model))
}

# Loop through each city and generate the model and summary for price
for (city in cities) {
  # Generate the model
  model <- lm(price ~ newyearseve, data = get(paste0("complete_data_", city)))
  
  # Print the summary
  cat("Summary for", toupper(city), "\n")
  print(summary(model))
}

##OUTPUT
save(model_booked, model_price, model_loop, file="./src/analysis/regression/model_results.R") 
#add loops saving here!!! <- i do not get how to do this only like this, without loop:
save(model_booked, model_price, model_booked_rome, model_price_rome, model_booked_ams, model_price_ams, model_booked_paris, model_price_paris, model_booked_london, model_price_london ,file="./src/analysis/regression/model_results_booked.R") 

# without loops: 
#linear regression for booked per city
#need to make a loop of this: per city

model_booked_rome <- lm(booked ~ newyearseve, data = complete_data_rome)
model_booked_ams <- lm(booked ~ newyearseve, data = complete_data_ams)
model_booked_paris <- lm(booked ~ newyearseve, data = complete_data_paris)
model_booked_london <- lm(booked ~ newyearseve, data = complete_data_london)

summary(model_booked_rome)
summary(model_booked_ams)
summary(model_booked_paris)
summary(model_booked_london)

#linear regression for price per city
#need to make a loop of this, per city
model_price_rome <- lm(price ~ newyearseve, data = complete_data_rome)
model_price_ams <- lm(price ~ newyearseve, data = complete_data_ams)
model_price_paris <- lm(price ~ newyearseve, data = complete_data_paris)
model_price_london <- lm(price ~ newyearseve, data = complete_data_london)

summary(model_price_rome)
summary(model_price_ams)
summary(model_price_paris)
summary(model_price_london)
