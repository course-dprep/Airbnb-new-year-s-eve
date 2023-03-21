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

# Read in the listing and calendar data for the current city
for (city in cities) {
  assign(paste0("listings-", city), read_csv(gzfile(paste0('../../data/',"listings-", city, ".csv.gz"))))
  assign(paste0("calendar-", city), read_csv(gzfile(paste0('../../data/',"calendar-", city, ".csv.gz"))))
}

## Data Selection ##
# Read in the listing and calendar data for the current city
for (city in cities) {
  assign(paste0("list_", city, "_filtered"), get(paste0("listings-", city)) %>% select(id, host_id, host_location, neighbourhood))
  assign(paste0("calendar_", city, "_filtered"), get(paste0("calendar-", city)) %>% select(listing_id, date, available, price, minimum_nights))
}

##TRANSFORMATION##
# Clean the listings file
# Rename the "id" column to "listing_id" for the current city's filtered listing data 
for (city in cities) {
  assign(paste0("list_", city, "_filtered"), get(paste0("list_", city, "_filtered")) %>% rename(listing_id = id))
}

# Clean the calender file
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
for(city in cities){
  calendar_filtered <- get(paste0("calendar_", city, "_filtered"))
  calendar_filtered <- calendar_filtered %>% group_by(date_old) %>% mutate(date = as.Date(date_old))
  calendar_filtered2 <- c('listing_id', 'date', 'booked', 'price', 'minimum_nights')
  calendar_filtered2 <- calendar_filtered[,which(colnames(calendar_filtered)%in%calendar_filtered2)]
  assign(paste0("calendar_", city, "_filtered"), calendar_filtered)
  assign(paste0("calendar_", city, "_filtered2"), calendar_filtered2)
}

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

#Add city_dum variable in calendar
for (city in cities) {
  calendar <- get(paste0("calendar_", city, "_filtered3"))
  calendar[[paste0(city, "_dum")]] <- city
  assign(paste0("calendar_", city, "_filtered3"), calendar)
}

# Add city variable in listing
list_london_filtered$city <- "London"
list_paris_filtered$city <- "Paris"
list_ams_filtered$city <- "Amsterdam"
list_rome_filtered$city <- "Rome"

# Merged calendar of all cities with bind the rows
merged_calendar <- bind_rows(calendar_london_filtered3, calendar_paris_filtered3, calendar_ams_filtered3, calendar_rome_filtered3)

#City_dum as dummy variable
for (i in seq_along(cities)) {
  city <- cities[i]
  merged_calendar[[paste0(city, "_dum")]] <- ifelse(merged_calendar[[paste0(city, "_dum")]] == city, 1, 0)
}

# Set NA in city_dum column as 0
merged_calendar<- merged_calendar%>%mutate_at(c('london_dum','paris_dum','ams_dum','rome_dum'), ~replace_na(.,0))

# Merged listing of all cities with bind the rows
merged_listing <- bind_rows(list_london_filtered, list_paris_filtered, list_ams_filtered, list_rome_filtered)

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
