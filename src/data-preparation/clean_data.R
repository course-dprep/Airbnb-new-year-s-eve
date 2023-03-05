## DATA CLEANING ##

# Creating gen/temp directory #
dir.create('../../data_newyearseve/data_prep_temp')

# load libraries #
library(tidyverse)
library(dplyr)
library(ggplot2)
library(readr)
library(stringr)

## INPUT File##
# London data
list_lon <- read_csv(gzfile("../../data_newyearseve/data_newyearsevelistings-london.csv.gz")) 
calendar_lon <- read_csv(gzfile("../../data_newyearseve/data_newyearsevecalendar-london.csv.gz"))
# Paris data
list_par <- read_csv(gzfile("../../data_newyearseve/data_newyearsevelistings-paris.csv.gz")) 
calendar_par <- read_csv(gzfile("../../data_newyearseve/data_newyearsevecalendar-paris.csv.gz"))
# Amsterdam data
list_ams <- read_csv(gzfile("../../data_newyearseve/data_newyearsevelistings-amsterdam.csv.gz")) 
calendar_ams <- read_csv(gzfile("../../data_newyearseve/data_newyearsevecalendar-amsterdam.csv.gz"))
# Rome data
list_rom <- read_csv(gzfile("../../data_newyearseve/data_newyearsevelistings-rome.csv.gz")) 
calendar_rom <- read_csv(gzfile("../../data_newyearseve/data_newyearsevecalendar-rome.csv.gz"))

## Data Selection ##
# London
list_lon_filtered <- list_lon %>% select(id, host_id, host_location, neighbourhood)
calendar_lon_filtered <- calendar_lon %>% select(listing_id, date, available, price, minimum_nights)
# Paris
list_par_filtered <- list_par %>% select(id, host_id, host_location, neighbourhood)
calendar_par_filtered <- calendar_par %>% select(listing_id, date, available, price, minimum_nights)
# Amsterdam
list_ams_filtered <- list_ams %>% select(id, host_id, host_location, neighbourhood)
calendar_ams_filtered <- calendar_ams %>% select(listing_id, date, available, price, minimum_nights)
# Rome
list_rom_filtered <- list_rom %>% select(id, host_id, host_location, neighbourhood)
calendar_rom_filtered <- calendar_rom %>% select(listing_id, date, available, price, minimum_nights)

## Cleaning the listings file ##
# Rename column "id" to "listing_id" to align with calendar file # 
list_lon_filtered <- list_lon_filtered %>% 
  rename(listing_id = id)
list_par_filtered <- list_par_filtered %>% 
  rename(listing_id = id)
list_ams_filtered <- list_ams_filtered %>% 
  rename(listing_id = id)
list_rom_filtered <- list_rom_filtered %>% 
  rename(listing_id = id)

## Cleaning the calender file ##
# Rename variable #  
calendar_lon_filtered <- calendar_lon_filtered %>% 
  rename(booked = available,date_old = date)
calendar_par_filtered <- calendar_par_filtered %>% 
  rename(booked = available,date_old = date)
calendar_ams_filtered <- calendar_ams_filtered %>% 
  rename(booked = available,date_old = date)
calendar_rom_filtered <- calendar_rom_filtered %>% 
  rename(booked = available,date_old = date)

# Booked as a dummy variable 
calendar_lon_filtered$booked <- ifelse(calendar_lon_filtered$booked=='FALSE',1,0)
calendar_par_filtered$booked <- ifelse(calendar_par_filtered$booked=='FALSE',1,0)
calendar_ams_filtered$booked <- ifelse(calendar_ams_filtered$booked=='FALSE',1,0)
calendar_rom_filtered$booked <- ifelse(calendar_rom_filtered$booked=='FALSE',1,0)

# Change type of date to a date 
calendar_lon_filtered <- calendar_lon_filtered %>% group_by(date_old) %>% mutate(date = as.Date(date_old))
calendar_par_filtered <- calendar_par_filtered %>% group_by(date_old) %>% mutate(date = as.Date(date_old))
calendar_ams_filtered <- calendar_ams_filtered %>% group_by(date_old) %>% mutate(date = as.Date(date_old))
calendar_rom_filtered <- calendar_rom_filtered %>% group_by(date_old) %>% mutate(date = as.Date(date_old))
calendar_lon_filtered2 <- c('listing_id', 'date', 'booked', 'price', 'minimum_nights')
calendar_lon_filtered2 <- calendar_lon_filtered[,which(colnames(calendar_lon_filtered)%in%calendar_lon_filtered2)]
calendar_par_filtered2 <- c('listing_id', 'date', 'booked', 'price', 'minimum_nights')
calendar_par_filtered2 <- calendar_par_filtered[,which(colnames(calendar_par_filtered)%in%calendar_par_filtered2)]
calendar_ams_filtered2 <- c('listing_id', 'date', 'booked', 'price', 'minimum_nights')
calendar_ams_filtered2 <- calendar_ams_filtered[,which(colnames(calendar_ams_filtered)%in%calendar_ams_filtered2)]
calendar_ron_filtered2 <- c('listing_id', 'date', 'booked', 'price', 'minimum_nights')
calendar_ron_filtered2 <- calendar_ron_filtered[,which(colnames(calendar_ron_filtered)%in%calendar_ron_filtered2)]

# Filter for time period (5 days before & after new years eve)
calendar_lon_filtered3 <- calendar_lon_filtered2[calendar_lon_filtered2$date >= "2022-12-26" & calendar_lon_filtered2$date <= "2023-01-05", ]
calendar_par_filtered3 <- calendar_par_filtered2[calendar_par_filtered2$date >= "2022-12-26" & calendar_par_filtered2$date <= "2023-01-05", ]
calendar_ams_filtered3 <- calendar_ams_filtered2[calendar_ams_filtered2$date >= "2022-12-26" & calendar_ams_filtered2$date <= "2023-01-05", ]
calendar_rom_filtered3 <- calendar_rom_filtered2[calendar_rom_filtered2$date >= "2022-12-26" & calendar_rom_filtered2$date <= "2023-01-05", ]

# Add New Years Eve as dummy variable 
calendar_lon_filtered3$newyearseve <- ifelse(calendar_lon_filtered3$date=="2022-12-31",1,0)
calendar_par_filtered3$newyearseve <- ifelse(calendar_par_filtered3$date=="2022-12-31",1,0)
calendar_ams_filtered3$newyearseve <- ifelse(calendar_ams_filtered3$date=="2022-12-31",1,0)
calendar_rom_filtered3$newyearseve <- ifelse(calendar_rom_filtered3$date=="2022-12-31",1,0)

# Add city variable
calendar_lon_filtered3$city <- "London"
calendar_par_filtered3$city <- "Paris"
calendar_ams_filtered3$city <- "Amsterdam"
calendar_rom_filtered3$city <- "Rome"

# Merged calendar of all cities with bind the rows
merged_calendar <- bind_rows(calendar_lon_filtered3, calendar_par_filtered3, calendar_ams_filtered3, calendar_rom_filtered3)

# Merged listing of all cities with bind the rows
merged_listing <- bind_rows(list_lon_filtered, list_par_filtered, list_ams_filtered, list_rom_filtered)

# Merged calendar and listing
complete_data_withNA <- inner_join(merged_calendar, merged_listing, by=c('listing_id'))

# Remove rows with missing data
complete_data <- na.omit(complete_data_withNA)


## TRANSFORMATION of complete_data ##
# Price as numeric
complete_data$price <- as.numeric(as.factor(complete_data$price)) 

# Separate by city
complete_data_lon <- complete_data %>% filter(complete_data$city == "London")
complete_data_par <- complete_data %>% filter(complete_data$city == "Paris")
complete_data_ams <- complete_data %>% filter(complete_data$city == "Amsterdam")
complete_data_ron <- complete_data %>% filter(complete_data$city == "Rome")


## OUTPUT ## 
write.csv(complete_data, "../../data_newyearseve/complete_data.csv")
write.csv(complete_data_lon, "../../data_newyearseve/complete_data_lon.csv")
write.csv(complete_data_par, "../../data_newyearseve/complete_data_par.csv")
write.csv(complete_data_ams, "../../data_newyearseve/complete_data_ams.csv")
write.csv(complete_data_ron, "../../data_newyearseve/complete_data_ron.csv")

