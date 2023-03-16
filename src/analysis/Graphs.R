library(broom)
library(tidyr)
library(ggplot2)
library(readr)
library(data.table)
library(dplyr)
library(tidyverse)
library(stargazer)
library(ggpubr)


##GRAPHS does not make sense yet !!!!! We need to look into what we want to show and what is relevant for our research question + need to make it a markdown!

regression_summary_booked <- summary(model_booked)
regression_summary_price <- summary(model_price)

#import the data per 
cities <- c("rome", "paris", "ams", "london")

for (city in cities) {
  file_name <- paste0("complete_data_", city, ".csv")
  assign(paste0(city), read_csv((paste0("../../gen/data-preparation/output/", "complete_data_",city, ".csv"))))
}

# Visualization #
# Plot for different cities 
boxplot_price_per_city <- ggplot(complete_data, aes(x=newyearseve, y=price, fill=city)) + 
  geom_boxplot() +
  facet_wrap(~newyearseve, scale="free") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

#create graph with mean price for London
london_mean_price_graph <- london %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + 
  geom_line(color = 'blue') + 
  geom_hline(yintercept = mean(london$price), color="black")

#create graph with mean price for Paris
paris_mean_price_graph <- paris %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + 
  geom_line(color = 'blue') + 
  geom_hline(yintercept = mean(paris$price), color="black")

#create graph with mean price for Rome
rome_mean_price_graph <- rome %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + 
  geom_line(color = 'blue') + 
  geom_hline(yintercept = mean(rome$price), color="black")

#create graph with mean price for Amsterdam
ams_mean_price_graph <- ams %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + 
  geom_line(color = 'blue') +  
  geom_hline(yintercept = mean(ams$price), color="black")

# Output
cities <- c("rome", "paris", "ams", "london")

for (city in cities) {
  # Generate plot object
  plot_obj <- get(paste0(city,"_mean_price_graph"))
  
  # Define file name and path
  file_name <- paste0(city,"_mean_price_graph", ".pdf")
  file_path <- paste("../../gen/analysis/output/", file_name, sep="")
  
  ggsave(file_path, plot = plot_obj)
}
