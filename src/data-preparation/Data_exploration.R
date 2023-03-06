#setwd("C:/R/R-4.2.2/bin/Dprep/CounEgAms")

# Setup
library(tidyverse)

# Input
# Load data sets from the different countries
filenames = c('listings-ams.csv','listings-london.csv', 'listings-paris.csv','listings-rome.csv')

# Transformation
lists_cities <- lapply(filenames, function(fn) {
  out = read_csv(fn)
  out = out %>% mutate(price_cleaned = as.numeric(gsub('[$]', '', price))) %>% mutate(filenames=fn)
  out
})

# Output
save(lists_cities, file='list_cities.RData')

# Input of your next file
#all_cities <- load('list_cities.RData')
