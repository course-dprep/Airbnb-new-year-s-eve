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

dir.create('../../src/analysis/analyze.R')

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

#Assumptions

#Normality
complete_data_sample <- sample_n(complete_data, 5000)
shapiro.test(complete_data_sample$price)

#add more if needed 


##complete model booked 

#linear regression (wrong i guess)
model_booked <- lm(booked ~ newyearseve, data = complete_data)
summary(model_booked)

#logistic regression
model_booked <- glm(booked ~ newyearseve, data = complete_data, family = binomial)
summary(model_booked)


##complete model price 
model_price <- lm(price ~ newyearseve, data = complete_data)
summary(model_price)


##Model per city booked
#linear regression for booked per city (wrong i guess)
# Loop through each city and generate the model and summary for booked
for (city in cities) {
  # Generate the model
  model <- lm(booked ~ newyearseve, data = get(paste0("complete_data_", city)))
  
  # Print the summary
  cat("Summary for", toupper(city), "\n")
  print(summary(model))
}

#logistic regression for booked per city
for (city in cities) {
  # Generate the model
  model <- glm(booked ~ newyearseve, family = binomial, data = get(paste0("complete_data_", city)))
  
  # Print the summary
  cat("Summary for", toupper(city), "\n")
  print(summary(model))
}

##Model per city price
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

# output without loops below: 

#linear regression for booked per city
model_booked_rome <- lm(booked ~ newyearseve, data = complete_data_rome)
model_booked_ams <- lm(booked ~ newyearseve, data = complete_data_ams)
model_booked_paris <- lm(booked ~ newyearseve, data = complete_data_paris)
model_booked_london <- lm(booked ~ newyearseve, data = complete_data_london)

summary(model_booked_rome)
summary(model_booked_ams)
summary(model_booked_paris)
summary(model_booked_london)

#logistic regression for price per city
model_price_rome <- glm(booked ~ newyearseve, family = binomial, data = complete_data_rome)
model_price_ams <- glm(booked ~ newyearseve, family = binomial, data = complete_data_ams)
model_price_paris <- glm(booked ~ newyearseve, family = binomial, data = complete_data_paris)
model_price_london <- glm(booked ~ newyearseve, family = binomial, data = complete_data_london)

summary(model_price_rome)
summary(model_price_ams)
summary(model_price_paris)
summary(model_price_london)
