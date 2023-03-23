library(broom)
library(tidyr)
library(ggplot2)
library(ggpubr)
library(readr)
library(dplyr)
library(tidyverse)
library(stargazer)

## INPUT ##
# Import the complete data 
complete_data <- read_csv("../../gen/data-preparation/output/complete_data.csv")

# Import the data per cities
cities <- c("rome", "paris", "ams", "london")

for (city in cities) {
  file_name <- paste0("complete_data_", city, ".csv")
  assign(paste0("complete_data_", city), read_csv((paste0("../../gen/data-preparation/output/", "complete_data_",city, ".csv"))))
}

## TRANSFORMATION ##
# Random sampling 10% of dataset#
sample_data <- complete_data[sample(nrow(complete_data),83924),]

sample_size_london <- round(0.1 * nrow(complete_data_london))
sample_data_london <- complete_data_london[sample(nrow(complete_data_london), sample_size_london),]
sample_size_paris <- round(0.1 * nrow(complete_data_paris))
sample_data_paris <- complete_data_paris[sample(nrow(complete_data_paris), sample_size_paris),]
sample_size_ams <- round(0.1 * nrow(complete_data_ams))
sample_data_ams <- complete_data_ams[sample(nrow(complete_data_ams), sample_size_ams),]
sample_size_rome <- round(0.1 * nrow(complete_data_rome))
sample_data_rome <- complete_data_rome[sample(nrow(complete_data_rome), sample_size_rome),]

# Descriptive of price
summary(sample_data$price)
mean_price <- mean(complete_data$price)
mean_price_sample <- mean(sample_data$price)
save(mean_price, file='../../gen/analysis/output/mean_price.RData')
histogram_prices <- hist(sample_data$price, xlab = 'price in €',ylab = 'numbers of Airbnb') 

# Descriptive of new years eve
summary(sample_data$newyearseve)
newyearseve_number <- table(sample_data$newyearseve)

# Linear regression with main effect:
price_linear <- lm(price ~ newyearseve, data = sample_data)
summary(price_linear)

# Model per city price: linear regression
# Loop through each city and generate the model and summary for price
price_cities_linear <- lapply(cities, function(city) {
  price_linear <- lm(price ~ newyearseve, data = get(paste0("sample_data_", city)))
  cat("Summary for", toupper(city), "\n")
  print(summary(price_linear))
  return(list(city=city, price_linear=price_linear))
})

# Add interactions between new years eve and cities:
price_cities_linear2 <- lm(price ~ newyearseve + london_dum + paris_dum + ams_dum + rome_dum, data = complete_data); 
summary(price_cities_linear2)

## Visualization ##
# Plot for overall
price_newyearseve_boxplot <- ggboxplot(data = sample_data, x="newyearseve", y="price",
                                         color="newyearseve", palette = c("#00AFBB", "#E7B800"),
                                         ylab= "Price", xlab="newyearseve")

# Plot for different cities 
price_per_city_boxplot <- ggplot(sample_data, aes(x=newyearseve, y=price, fill=city)) + 
  geom_boxplot() +
  facet_wrap(~newyearseve, scale="free") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

# Create graph with mean price for London
london_mean_price_graph <- complete_data_london %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price,)) + ggtitle("Avarage Price in London")+
  geom_line(color = 'blue') + 
  geom_hline(yintercept = mean(complete_data_london$price), color="black")

# Create graph with mean price for Paris
paris_mean_price_graph <- complete_data_paris %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + ggtitle("Avarage Price in Paris")+
  geom_line(color = 'blue') + 
  geom_hline(yintercept = mean(complete_data_paris$price), color="black")

# Create graph with mean price for Rome
rome_mean_price_graph <- complete_data_rome %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + ggtitle("Avarage Price in Rome")+
  geom_line(color = 'blue') + 
  geom_hline(yintercept = mean(complete_data_rome$price), color="black")

# Create graph with mean price for Amsterdam
ams_mean_price_graph <- complete_data_ams %>% 
  group_by(date) %>%
  summarize(mean_price = mean(price)) %>%
  ggplot(aes(x = date, y = mean_price)) + ggtitle("Avarage Price in Amsterdam")+
  geom_line(color = 'blue') +  
  geom_hline(yintercept = mean(complete_data_ams$price), color="black")


## OUTPUT ##
cities <- c("rome", "paris", "ams", "london")

for (city in cities) {
plot_obj <- get(paste0(city,"_mean_price_graph"))
file_name <- paste0(city,"_mean_price_graph", ".pdf")
file_path <- paste("../../gen/analysis/output/", file_name, sep="")
ggsave(file_path, plot = plot_obj,width=3, height=3)
}
ggsave(plot = price_newyearseve_boxplot, filename = "../../gen/analysis/output/price_newyearseve_boxplot.pdf",width=4.5, height=4.5)
ggsave(plot = price_per_city_boxplot, filename = "../../gen/analysis/output/price_per_city_boxplot.pdf",width=4.5, height=4.5)
save(price_linear, price_cities_linear, price_cities_linear2, file='../../gen/analysis/output/model_results.RData') 
