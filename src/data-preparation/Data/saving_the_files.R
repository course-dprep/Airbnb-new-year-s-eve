# Define the list of cities and filenames
cities <- c("ams", "london", "paris", "rome")
filenames <- paste0("listings-", cities, ".csv.gz")

# Loop through each city and read in the data
for (i in seq_along(cities)) {
  # Read in the listings data
  assign(paste0("list_", cities[i]), read_csv(filenames[i]))
  
  # Read in the calendar data
  assign(paste0("cal_", cities[i]), read_csv(paste0("calendar-", cities[i], ".csv.gz")))
}

file_names <- c( 'listings-ams.csv.gz', "listings-london.csv.gz", "listings-paris.csv.gz", "listings-rome.csv.gz")
city_names <- c('Amsterdam', 'London', 'Paris', 'Rome')

# Loop through the file names and perform the same operations on each file
for (i in 1:length(file_names)) {
  list_data <- read_csv(file_names[i])
  list_prices <- list_data$price[!is.na(list_data$price)]
  list_prices <- as.numeric(gsub("\\$", "", list_prices))
  list_prices_summary <- summary(list_prices)
  print(paste("This is the price summary statistics for", city_names[i], ":" , list_prices_summary))
  
}

city_names <- c("ams", "london", "paris", "rome")

for(city in city_names) {
  assign(paste0("cal_", city), get(paste0("cal_", city)) %>%
           mutate(price = ifelse(!is.na(price), as.numeric(gsub("\\$", "", price)), price)))
}

view(cal_Ams)