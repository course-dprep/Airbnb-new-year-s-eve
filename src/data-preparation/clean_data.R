## DATA CLEANING ##

# load libraries #
library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)
library(car)

## INPUT ##
# Create a vector of city names
cities <- c("london", "paris", "ams", "rome")

# Merge all listings and calendar data for the current cities
listings <- purrr::map_df(cities, ~ read_csv(gzfile(paste0('../../data/',"listings-", .x, ".csv.gz"))), .id = "city")
calendar <- purrr::map_df(cities, ~ read_csv(gzfile(paste0('../../data/',"calendar-", .x, ".csv.gz"))), .id = "city")

## Data Selection ##
# Select relevant columns for listings and calendar data for the current cities
listings_filtered <- listings %>% select(city, id, host_id, host_location, neighbourhood)
calendar_filtered <- calendar %>% select(city, listing_id, date, available, price, minimum_nights)

## TRANSFORMATION ##
# Clean the listings file
# Rename the "id" column to "listing_id" for the current cities' filtered listing data 
listings_filtered <- listings_filtered %>% rename(listing_id = id)

# Clean the calendar file
# Rename the "available" column to "booked" and the "date" column to "date_old" for the current cities' filtered calendar data 
calendar_filtered <- calendar_filtered %>% rename(booked = available, date_old = date)

# Create a dummy variable "booked" for the current cities' filtered calendar data
calendar_filtered <- calendar_filtered %>% mutate(booked = ifelse(booked == "FALSE", 1, 0))

# Change type of date to a date 
calendar_filtered <- calendar_filtered %>% group_by(city) %>% mutate(date = as.Date(date_old)) %>% ungroup() %>% 
  select(city, listing_id, date, booked, price, minimum_nights)

# Filter for time period (5 days before & after new years eve)
start_date <- "2022-12-26"
end_date <- "2023-01-05"

# Filter calendar data for time period for each city
calendar_filtered <- calendar_filtered %>% filter(date >= start_date & date <= end_date)

# Add New Years Eve as dummy variable 
calendar_filtered <- calendar_filtered %>% mutate(newyearseve = ifelse(date=="2022-12-31",1,0))

# Add city_dum variable in calendar
calendar_filtered <- calendar_filtered %>% mutate(across(city, ~if_else(. == city, 1, 0), .names = "{.col}_dum"))

# Add city variable in listings
listings_filtered <- listings_filtered %>% mutate(city = tolower(city))

# Merge calendar of all cities with bind the rows
merged_calendar <- calendar_filtered %>% 
  select(-city_dum) %>% 
  pivot_wider(names_from = city, values_from = c(date, booked, newyearseve), names_prefix = paste("", "_")) %>% 
  mutate(across(ends_with("_dum"), ~if_else(. == 1, str_replace(., "_dum", ""), "")))

# Merged listing of all cities with bind the rows
merged_listing <- listings_filtered

# Merged calendar and listing
complete_data_withNA <- left_join(merged_calendar, merged_listing, by=c('listing_id'))

## TRANSFORMATION of complete_data ##
# Remove $ symbol of Price column and convert to numeric variable
complete_data_withNA$price <- gsub('[$]', '', complete_data_withNA$price) %>% as.numeric(as.character(complete_data_withNA$price)) 

# Remove rows with missing data
complete_data <- na.omit(complete_data_withNA)

# Separate files by city
complete_data_london <- complete_data %>% filter(complete_data$city == "London")
complete_data_paris <- complete_data %>% filter(complete_data$city == "Paris")
complete_data_ams <- complete_data %>% filter(complete_data$city == "Amsterdam")
complete_data_rome <- complete_data %>% filter(complete_data$city == "Rome")

## OUTPUT ##
# Create a list of the complete_data objects
complete_data_list <- list(
  complete_data,
  complete_data_london,
  complete_data_paris,
  complete_data_ams,
  complete_data_rome
)

# Loop through the list of complete_data objects and write each object to a separate CSV file
for (i in seq_along(complete_data_list)) {
  file_name <- paste("complete_data", c("","_london", "_paris", "_ams", "_rome")[i], ".csv", sep = "")
  file_path <- paste("../../gen/data-preparation/output/", file_name, sep = "")
  write_csv(complete_data_list[[i]], file_path)
}
