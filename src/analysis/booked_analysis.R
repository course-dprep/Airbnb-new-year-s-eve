library(broom)
library(tidyr)
library(ggplot2)
library(ggpubr)
library(readr)
library(dplyr)
library(tidyverse)
library(stargazer)

## INPUT ##
# Import the complete data 
complete_data <- read_csv("../../gen/data-preparation/output/complete_data.csv")

# Import the data per cities
cities <- c("rome", "paris", "ams", "london")

for (city in cities) {
  file_name <- paste0("complete_data_", city, ".csv")
  assign(paste0("complete_data_", city), read_csv((paste0("../../gen/data-preparation/output/", "complete_data_",city, ".csv"))))
}

## TRANSFORMATION ##
# Descriptive of booked
summary(complete_data$booked)
mean_booked <- mean(complete_data$booked)
save(mean_booked, file = '../../gen/analysis/output/mean_booked.RData')

complete_data_newyearseve <- complete_data %>% filter (newyearseve==1)
complete_data_newyearseve %>% count(complete_data_newyearseve$booked)
complete_data_nonnewyearseve <- complete_data %>% filter (newyearseve==0)
complete_data_nonnewyearseve %>% count(complete_data_nonnewyearseve$booked)


# Checked normality
set.seed(5000)
complete_data_sample <- rnorm(5000)
shapiro.test(complete_data_sample)

## Logistic regression for total bookings
booked_logistic <- glm(booked ~ newyearseve, complete_data, family = binomial)
summary(booked_logistic)
exp(booked_logistic$coefficients)
histogram_total_booked <- hist(complete_data$booked, xlab = 'booked') 

# Model fit of total bookings 
booked_logistic_chisq <- booked_logistic$null.deviance-booked_logistic$deviance 
booked_logistic_chisqdf <- booked_logistic$df.null-booked_logistic$df.residual 
booked_logistic_chisq_prob = 1-pchisq(booked_logistic_chisq,booked_logistic_chisqdf) 

## Logistic regression for booking in each city
# Loop through each city and generate the model and summary for booked (logistic regression)
booked_cities_logistic <- lapply(cities, function(city) {
  booked_logistic <- glm(booked ~ newyearseve, family = binomial, data = get(paste0("complete_data_", city)))
  cat("Summary for", toupper(city), "\n")
  print(summary(booked_logistic))
  return(list(city=city, booked_logistic=booked_logistic))
})

## OUTPUT ##
stargazer(booked_logistic, apply.coef=exp, apply.se = exp, type="html", title="Effect of New Years Eve on Number of Bookings of Airbnb Listings",
          dep.var.caption = "Number of bookings",
          dep.var.labels="",
          column.labels = 'Total',
          covariate.labels="New years eve", out='../../gen/analysis/output/model_bookings.html')

