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
list_lon_filtered <- list_lon %>% select(id, host_id, host_location, neighbourhood, minimum_nights, price)
calendar_lon_filtered <- calendar_lon %>% select(listing_id, date, available, price, minimum_nights)
# Paris
list_par_filtered <- list_par %>% select(id, host_id, host_location, neighbourhood, minimum_nights, price)
calendar_par_filtered <- calendar_par %>% select(listing_id, date, available, price, minimum_nights)
# Amsterdam
list_ams_filtered <- list_ams %>% select(id, host_id, host_location, neighbourhood, minimum_nights, price)
calendar_ams_filtered <- calendar_ams %>% select(listing_id, date, available, price, minimum_nights)
# Rome
list_rom_filtered <- list_rom %>% select(id, host_id, host_location, neighbourhood, minimum_nights, price)
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
  rename(booked = available)
calendar_par_filtered <- calendar_par_filtered %>% 
  rename(booked = available)
calendar_ams_filtered <- calendar_ams_filtered %>% 
  rename(booked = available)
calendar_rom_filtered <- calendar_rom_filtered %>% 
  rename(booked = available)

# Change type of date to a date 
calendar_lon_filtered <- calendar_lon_filtered %>% group_by(date) %>% mutate(date = as.Date(date))
calendar_par_filtered <- calendar_par_filtered %>% group_by(date) %>% mutate(date = as.Date(date))
calendar_ams_filtered <- calendar_ams_filtered %>% group_by(date) %>% mutate(date = as.Date(date))
calendar_rom_filtered <- calendar_rom_filtered %>% group_by(date) %>% mutate(date = as.Date(date))

# Filter for time period (two-weeks before & after Valentine's day)
calendar_lon_filtered2 <- calendar_lon_filtered[calendar_lon_filtered$date >= "2022-12-26" & calendar_lon_filtered$date <= "2023-01-05", ]
calendar_par_filtered2 <- calendar_par_filtered[calendar_par_filtered$date >= "2022-12-26" & calendar_par_filtered$date <= "2023-01-05", ]
calendar_ams_filtered2 <- calendar_ams_filtered[calendar_ams_filtered$date >= "2022-12-26" & calendar_ams_filtered$date <= "2023-01-05", ]
calendar_rom_filtered2 <- calendar_rom_filtered[calendar_rom_filtered$date >= "2022-12-26" & calendar_rom_filtered$date <= "2023-01-05", ]

# Booked as a dummy variable 
calendar_lon_filtered$booked <- ifelse(calendar_lon_filtered$booked=='FALSE',1,0)
calendar_par_filtered$booked <- ifelse(calendar_par_filtered$booked=='FALSE',1,0)
calendar_ams_filtered$booked <- ifelse(calendar_ams_filtered$booked=='FALSE',1,0)
calendar_rom_filtered$booked <- ifelse(calendar_rom_filtered$booked=='FALSE',1,0)





