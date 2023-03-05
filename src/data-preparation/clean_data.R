## DATA CLEANING ##

##Set working directory##
setwd("C:/R/R-4.2.2/bin/airbnb_newyearseve")

# load libraries #
library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)
library(stringr)

# Input files #
# Create a vector of city names
cities <- c("london", "paris", "ams", "rome")

# Loop through the cities vector
for (city in cities) {
  # Read in the listing and calendar data for the current city
  assign(paste0("listings-", city), read_csv(gzfile(paste0("listings-", city, ".csv.gz"))))
  assign(paste0("calendar-", city), read_csv(gzfile(paste0("calendar-", city, ".csv.gz"))))
}

## Data Selection ##
for (city in cities) {
  # Read in the listing and calendar data for the current city
  assign(paste0("list_", city, "_filtered"), get(paste0("listings-", city)) %>% select(id, host_id, host_location, neighbourhood))
  assign(paste0("calendar_", city, "_filtered"), get(paste0("calendar-", city)) %>% select(listing_id, date, available, price, minimum_nights))
}

## Cleaning the listings file ##
# Rename column "id" to "listing_id" to align with calendar file 
for (city in cities) {
  # Rename the "id" column to "listing_id" for the current city's filtered listing data
  assign(paste0("list_", city, "_filtered"), get(paste0("list_", city, "_filtered")) %>% rename(listing_id = id))
}

## Cleaning the calender file ##
# Rename the "available" column to "booked" and the "date" column to "date_old" for the current city's filtered calendar data 
for (city in cities) {
  assign(paste0("calendar_", city, "_filtered"), get(paste0("calendar_", city, "_filtered")) %>% 
           rename(booked = available, date_old = date))
}

# Create a dummy variable "booked" for the current cities' filtered calendar data
for (city in cities) {
  assign(paste0("calendar_", city, "_filtered"), get(paste0("calendar_", city, "_filtered")) %>% 
           mutate(booked = ifelse(booked == "FALSE", 1, 0)))
}

# Change type of date to a date 
calendar_london_filtered <- calendar_london_filtered %>% group_by(date_old) %>% mutate(date = as.Date(date_old))
calendar_paris_filtered <- calendar_paris_filtered %>% group_by(date_old) %>% mutate(date = as.Date(date_old))
calendar_ams_filtered <- calendar_ams_filtered %>% group_by(date_old) %>% mutate(date = as.Date(date_old))
calendar_rome_filtered <- calendar_rome_filtered %>% group_by(date_old) %>% mutate(date = as.Date(date_old))
calendar_london_filtered2 <- c('listing_id', 'date', 'booked', 'price', 'minimum_nights')
calendar_london_filtered2 <- calendar_london_filtered[,which(colnames(calendar_london_filtered)%in%calendar_london_filtered2)]
calendar_paris_filtered2 <- c('listing_id', 'date', 'booked', 'price', 'minimum_nights')
calendar_paris_filtered2 <- calendar_paris_filtered[,which(colnames(calendar_paris_filtered)%in%calendar_paris_filtered2)]
calendar_ams_filtered2 <- c('listing_id', 'date', 'booked', 'price', 'minimum_nights')
calendar_ams_filtered2 <- calendar_ams_filtered[,which(colnames(calendar_ams_filtered)%in%calendar_ams_filtered2)]
calendar_rome_filtered2 <- c('listing_id', 'date', 'booked', 'price', 'minimum_nights')
calendar_rome_filtered2 <- calendar_rome_filtered[,which(colnames(calendar_rome_filtered)%in%calendar_rome_filtered2)]


# Filter for time period (5 days before & after new years eve)
start_date <- "2022-12-26"
end_date <- "2023-01-05"

# Loop over cities and filter calendar data for time period
for(city in cities) {
  calendar_filtered <- get(paste0("calendar_", city, "_filtered2"))
  assign(paste0("calendar_", city, "_filtered3"), calendar_filtered[calendar_filtered$date >= start_date & calendar_filtered$date <= end_date, ])
}

# Add New Years Eve as dummy variable 
for(city in cities){
  assign(paste0("calendar_", city, "_filtered3"), 
         get(paste0("calendar_", city, "_filtered3")) %>% 
           mutate(newyearseve = ifelse(date=="2022-12-31",1,0)))
}

# Add city variable
calendar_london_filtered3$city <- "London"
calendar_paris_filtered3$city <- "Paris"
calendar_ams_filtered3$city <- "Amsterdam"
calendar_rome_filtered3$city <- "Rome"

# Merged calendar of all cities with bind the rows
merged_calendar <- bind_rows(calendar_london_filtered3, calendar_paris_filtered3, calendar_ams_filtered3, calendar_rome_filtered3)

# Merged listing of all cities with bind the rows
merged_listing <- bind_rows(list_london_filtered, list_paris_filtered, list_ams_filtered, list_rome_filtered)

# Merged calendar and listing
complete_data_withNA <- inner_join(merged_calendar, merged_listing, by=c('listing_id'))

# Remove rows with missing data
complete_data <- na.omit(complete_data_withNA)

## TRANSFORMATION of complete_data ##
# Set price as a number, remove $ symbol
complete_data$price <- gsub('[$]', '', complete_data$price)

# Separate files by city
complete_data_london <- complete_data %>% filter(complete_data$city == "London")
complete_data_paris <- complete_data %>% filter(complete_data$city == "Paris")
complete_data_ams <- complete_data %>% filter(complete_data$city == "Amsterdam")
complete_data_rome <- complete_data %>% filter(complete_data$city == "Rome")

## OUTPUT ## 
write_csv(complete_data, "complete_data.csv")
write_csv(complete_data_london, "complete_data_london.csv")
write_csv(complete_data_paris, "complete_data_paris.csv")
write_csv(complete_data_ams, "complete_data_ams.csv")
write_csv(complete_data_rome, "complete_data_rome.csv")

