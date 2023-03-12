library(broom)
library(tidyr)
library(ggplot2)
library(readr)
library(data.table)
library(dplyr)
library(tidyverse)
library(stargazer)

##GRAPHS does not make sense yet !!!!! We need to look into what we want to show and what is relevant for our research question + need to make it a markdown!

regression_summary_booked <- summary(model_booked)
regression_summary_price <- summary(model_price)

London <- read_csv('complete_data_london.csv')
Paris <- read_csv('complete_data_paris.csv')
Rome <- read.csv('complete_data_rome.csv')
Amsterdam <- read_csv('complete_data_ams.csv')

# Visualization #
# Plot for different cities 
boxplot_price_per_city <- ggplot(complete_data, aes(x=newyearseve, y=price, fill=city)) + 
  geom_boxplot() +
  facet_wrap(~newyearseve, scale="free") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

#create graph with mean price for London
London_mean_price_graph <- London %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + 
  geom_line(color = 'blue') + 
  geom_hline(yintercept = mean(London$price), color="black")

#create graph with mean price for Paris
Paris_mean_price_graph <- Paris %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + 
  geom_line(color = 'blue') + 
  geom_hline(yintercept = mean(London$price), color="black")

#create graph with mean price for Rome
Rome_mean_price_graph <- Rome %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + 
  geom_line(color = 'blue') + 
  geom_hline(yintercept = mean(London$price), color="black")

#create graph with mean price for Amsterdam
Amsterdam_mean_price_graph <- Amsterdam %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + 
  geom_line(color = 'blue') +  
  geom_hline(yintercept = mean(London$price), color="black")


