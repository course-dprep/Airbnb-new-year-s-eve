# Airbnb New Year's Eve 

Welcome to our research project!

![image](https://user-images.githubusercontent.com/123902060/220652672-82bcdd9e-0f1a-4cfe-bdeb-f8dfcbed94f1.png)

## Motivation
“May the new year take you to places you have never been before”

However, traveling to new places requires a lot of planning and coordination, such as finding the right accommodation. As we all know, searching for accommodation, especially in capital cities, can be quite frustrating, especially during the holidays. Thanks to Airbnb, offering many affordable options, this has become a thing of the past. 

This study aims to analyze the effects of one of the biggest holidays on Airbnb listings: New Year’s eve. We believe that New Year’s eve could influence the price of listings and the availability of Airbnb’s during this end-of-year period. Among all holidays, we chose New Year’s Eve because it is celebrated across the world, happens each year on the same date, and is celebrated by all ages. To analyze the effect, we selected European cities that are well-known both inside and outside of Europe: London, Paris, Amsterdam, and Rome. 

Furthermore we took into account the size/population and costliness of the cities in our selection to ensure they did not influence the results. For the holiday, we considered the events that provided data for multiple cities before, during and after the event. 

### Research Question
*What is the effect of New Year’s eve on Airbnb listings in Capital cities in Europe?*

## Method and Results

### Method
Inside Airbnb provided the information needed for this research project. To analyze the effects of prices of Airbnb accommodations during a New Year's Eve in capital cities in Europe, we will use a linear regression analysis since we are going to examine the relationship between a metric dependent variable and a metric independent variables. In addition, we also want to observe what is the effect of different cities. Moreover, the ability to accurately and scientifically forecast the future using linear regression models has been demonstrated. Moreover, to analyze the effects of the bookings of Airbnb accommodations during a New Year's Eve in capital cities in Europe, we will use a logistic regression analysis. A logistic regression is performed here, as we set dependent variable "booked" as dummy variable. The odds ratios can be easily calculated and interpreted in logistic regression models by encoding all of the independent variables as dummy variables, which also improves the stability and significance of the coefficients.The analysis will be done in RStudio, since this program allows us for preparing and analyzing the data.

In order to conduct this study, we examined data beginning five days before New Year's Eve 2022 (December 26th) and ending five days after New Year's Eve 2022 (January 5th). To compare the impact of New Year's Eve with other, "regular" days, we made a dummy for New Year's Eve. For the analysis, we contrast London, Paris, Amsterdam, and Rome as these are four of Europe's big cities. This allows us to determine whether the city itself—such as the fact that it is a more popular city—does not have an impact on the prices and bookings of the Airbnb’s.

![Schermafbeelding 2023-03-16 om 10 29 14](https://user-images.githubusercontent.com/122876103/225574072-b0c7ef9a-4902-49b4-b79b-b41120d44531.png)

### Variables used in the study

| **Variable**  | **Description**                                                                       | **Data** |
| ------------- | ------------------------------------------------------------------------------------- | -------- |
| price         | The listing price of an Airbnb per night in dollars                                   | numeric  |
| booked        | Dummy variable: whether the accomodation is not booked (0) or it is booked (1)        | numeric  |
| newyearseve   | Dummy variable: whether it is not New Year's Eve (0) or it is (1) on that specific day| numeric  |
| city          | The city of the Airbnb listing (London, Paris, Amsterdam or Rome)                     | character|



To build a new dataset, the listing- and calendar datasets of Rome, Amsterdam, Londen and Paris, retrieved from insideairbnb, are combined. This new dataset is cleaned up and it is checked for relevant elements before analysis. These sets enable analysis for every listing for every specific day, allowing for price comparisons between dates. To supplement the calendar dataset with additional data, the listings dataset will be combined with it and this will be saved in a file with the name complete_data.csv. Moreover, the data per city will be saved seperately in a file with the name complete_data_cityname.csv. 

### Relevance

This research project gives valuable insights in the prices and availablity of Airbnb's with New Year's Eve compared between multiple capital cities in Europe. For customers of Airbnb, this research gives them insights into the prices of an Airbnb with New Year's eve and the availability. Based on the results, predictions can be made for the next year.

### Results

**Price**: H1: New Year’s Eve influences the prices of Airbnb listings. 

The results show a P-value of <0.01 for both the complete model and the different cities separate. Therefore, with a significance of 0.05, the H0 can be rejected. Therefore, we can state that there is a significant relationship between New Year’s Eve and prices of Airbnb listings. The estimate of New Year's Eve is positive for the complete datasets and for the cities seperate. This means that we can concluded that prices will be higher during New Year's Eve. Moreover, it is striking that the prices of Airbnbs in Paris, London and Rome are comparable. On the other hand, prices in Amsterdam are significantly higher in the same timeperiod.

**Bookings**: H1: New Year’s Eve influences the amount of booked Airbnbs. 

The results from the logistic regression show a P-value<0.01 for both the complete model and the different cities seperate. Therefore, with a significance of 0.05, the null hypothesis can be rejected. By examining the exponents, we discovered that the impact across Paris, London, and Amsterdam is very similar, but they are all very different from Rome. The likelihood of an Airbnb being booked on New Year's Eve in Amsterdam increases by 0.692, in Paris increases by 0.451 and in London increases by 0.470. While these odds increase by 1.029 in Rome respectively. This demonstrates that the likelihood of booking an Airbnb on New Year’s Eve is the highest in Rome. 

## Conclusion

In answering the research question, it was found that there is a significant relationship between New Year's Eve and the prices of Airbnb listings. This applies for listings in Rome, London, Paris and Amsterdam, together and for the cities individually. We found that the average price in different cities is higher on New Year's Eve compared to the usual days.

Furthermore, a significant relationship between New Year's Eve and the likelihood that an Airbnb listing would be booked has been found. The chances of a listing being booked in Rome, London Paris and Amsterdam increases on New Year’s Eve. 

## Repository overview

The directory structure is as follow:
```
├── src
|   ├── analysis
|       ├── booked_analysis.R
|       ├── price_analysis.R
|       ├── makefile
|       ├── Report.Rmd
|       ├── Report.pdf
|   ├── data-preparation
|       ├── data_exploration.Rmd
|       ├── clean_data.R
|       ├── download_data.R
|       ├── makefile
|   ├── clean-up.R
├── gen
|   ├── analysis
|       ├── output
|       ├── temp
|   ├── data-preparation      
|       ├── output
|       ├── temp
├── .gitignore
├── Install packages.R
├── README.md
└── makefile

```


The main aim of this to have a basic structure, which can be easily adjusted to use in an actual project.  In this example project, the following is done: 
1. Download and prepare data
2. Run some analysis
3. Present results in a final pdf generated

## Dependencies
Please follow the installation guides on http://tilburgsciencehub.com/. :

- R. [Installation guides](https://tilburgsciencehub.com/building-blocks/configure-your-computer/statistics-and-computation/r/)
- Make. [Installation guides](https://tilburgsciencehub.com/building-blocks/configure-your-computer/automation-and-workflows/make/)


For R, make sure you have installed the following R packages:
```
install.packages(“readr”)
install.packages(“dplyr”)
install.packages(“ggplot2”)
install.packages(“tidyverse”)
install.packages(“ggpubr”)
install.packages(“car”)
install.packages(“scales”)
install.packages(“stargazer”)
```

## Running instructions

It is suggested to use the make file to execute the code. Please adhere to the instructions below:
1.	Fork this repository
2.	Open your command line/terminal and run:
```
git clone https://github.com/{your username}/Airbnb-new-years-eve.git
```
3.	Set your working directory to:
```
Airbnb-new-years-eve
```
4.	First, type ‘make -n’ in the terminal. R will then demonstrate everything it will run:
```
make -n
```
5.	Run make.  All code will be executed by make. If necessary, R will make sure the right packages are installed. Windows users will need to install Make in order for the main makefile to run. Make will be installed automatically for Mac and Linux OS users. After running make, all output will be produced. The following command can be used to run make after installing Make:
```
make
```
6.	Execute the following code in the command line/terminal to clean the data of any raw and unnecessary data files produced during the pipeline:
```
make clean
```

Alternatively, the scripts and files might be executed in the following order:

1.	Install packages: ../../src/data-preparation/Install_packages.R
2.	Download data: ../../src/data-preparation/download_data.R
3.	Clean data: ../../src/data-preparation/clean_data.R
4.	Explore data: ../../src/data-preparation/data_exploration.Rmd
5.	Booked analysis: ../../src/analysis/booked_analysis.R
6.	Price analysis: ../../src/analysis/price_analysis.R
7.	Final report: ../../src/analysis/Report.Rmd

## More resources
* Insideairbnb (http://insideairbnb.com/get-the-data/)

## About

This repository was created as a part of the Data Preparation and Workflow Managemant course in the Marketing Analytics Master of Tilburg University. The following students contributed to the creation of this repository:

* Fleur Le Mire
* Mariëlla van Erve
* Nishtha Staice
* Yi Ting Tsai
* Hilal Nur Turer


## Notes
* `make clean` removes all unnecessary temporary files. 
* Tested under Linux Mint (should work in any linux distro, as well as on Windows and Mac) 
* IMPORTANT: In `makefile`, when using `\` to split code into multiple lines, no space should follow `\`. Otherwise Gnu make aborts with error 193. 
* Many possible improvements remain. Comments and contributions are welcome!
