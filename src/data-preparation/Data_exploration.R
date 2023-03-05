setwd("C:/R/R-4.2.2/bin/Dprep/CounEgAms")

list_ams <- read_csv('listings-ams.csv')
list_lon <- read_csv ('listings-london.csv')
list_par <- read_csv('listings-paris.csv')
list_rom <- read_csv('listings-rome.csv')

# Load data sets from the different countries
filenames = c('listings-ams.csv','listings-london.csv', 'listings-paris.csv','listings-rome.csv')

lists_cities <- lapply(filenames, function(fn) {
  out = read_csv(fn)
  out %>% mutate(price_cleaned = as.numeric(gsub('[$]', '', price))) %>% mutate(filenames=fn)
  out
  
list_cities <- lapply(filenames, process_listings )
save(lists_cities, file='list_cities.RData')
})

all_cities <- load('list_cities.RData')
