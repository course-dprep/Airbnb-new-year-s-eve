# Airbnb New Year's Eve 

Welcome to our research project!

![image](https://user-images.githubusercontent.com/123902060/220652672-82bcdd9e-0f1a-4cfe-bdeb-f8dfcbed94f1.png)

## Motivation
“May the new year take you to place you have never been before”

However, traveling to new places requires a lot of planning and coordination, such as finding the right accommodation. As we all know, searching for accommodation, especially in capital cities, can be quite frustrating, especially during the holidays. Thanks to Airbnb, offering many affordable options, this has become a thing of the past. 

This study aims to analyze the effects of one of the biggest holidays on Airbnb listings: New Year’s eve. We believe that New Year’s eve could influence the price of listings and the availability of Airbnb’s during this end-of-year period. Among all holidays, we chose New Year’s Eve because it is celebrated across the world, happens each year on the same date, and is celebrated by all ages. To analyze the effect, we selected European cities that are well-known both inside and outside of Europe: London, Paris, Amsterdam, and Rome. 

Furthermore we took into account the size/population and costliness of the cities in our selection to ensure they did not influence the results. For the holiday, we considered the events that provided data for multiple cities before, during and after the event. 

### Research Question
What is the effect of New Year’s eve on Airbnb listings in Capital cities in Europe?

## Method and Results
Inside Airbnb [insideairbnb](http://insideairbnb.com/get-the-data/) provided the information needed for this research project. To analyze the price mark-up and the availability of Airbnb accommodations during a New Year's Eve in capital cities in Europe, we will use a regression analysis. In order to conduct this study, we examined data beginning five days before New Year's Eve 2022 (December 27th) and ending five days after New Year's Eve 2022 (January 5th). To compare the impact of New Year's Eve with other, "regular" days, we made a dummy for the event. For the analysis, we contrast London, Paris, Amsterdam, and Rome—four of Europe's big cities. This allows us to determine whether the city itself—such as the fact that it is a more popular city—does not have an impact on the prices and availability of the Airbnb’s.

![image](https://user-images.githubusercontent.com/122876103/219945498-c7cecd56-56a0-4293-b8db-7a66a29415fe.png)

### Variables used in the study

![image](https://user-images.githubusercontent.com/122876103/219945707-b1d39c4c-32af-409f-8796-d8b4500c7243.png)

To build a new dataset, the listing- and calendar datasets of Rome, Amsterdam, Londen and Paris, retrieved from insideairbnb, are combined. This new dataset is cleaned up. Moreover, it is checked for relevant elements before analysis. These sets enable analysis for every listing for every specific day, allowing for price comparisons between dates. To supplement the calendar dataset with additional data, the listings dataset will be combined with it. Regression analysis can be used with this cleaned-up dataset to analyze data that is relevant to our research questions.

### Results

*Price*: H1: New Year’s Eve influences the prices of Airbnb listings. The results show a P-value of <0.01 for both the complete model and the different cities separate. Therefore, with a significance of 0.05, the H0 can be rejected. Therefore, we can state that there is a significant relationship between New Year’s Eve and prices of Airbnb listings. Not finished yet. 

*Bookings*: H1: New Year’s Eve influences the amount of booked Airbnbs. The results from the logistic regression show a P-value<0.01 for both the complete model and the different cities seperate. Therefore, with a significance of 0.05, the null hypothesis can be rejected. By examining the exponents, we discovered that the impact across Paris, London, and Amsterdam is very similar, but they are all very different from Rome. The likelihood of an Airbnb being booked on New Year's Eve in Amsterdam increases by 0.692, in Paris increases by 0.451 and in London increases by 0.470. While these odds increase by 1.029 in Rome respectively. This demonstrates that the likelihood of booking an Airbnb on New Year’s Eve is the highest in Rome. 

## Conclusion

## Repository overview

The directory structure is as follow:
```
├── src
|   ├── analysis
|       ├── analyze.R
|       ├── update_input.R
|   ├── data-preparation
|       ├── Data_exploration.R
|       ├── Install packages
|       ├── New_Years.Rmd
|       ├── clean_data.R
|       ├── download_data.R
|       ├── makefile
|       ├── merge_data.R
|       ├── update_input.R
|   ├── paper
|       ├── paper.tex
|       ├── tables.R
|   ├── clean-up.R
├── data
|   ├── dataset1
|   ├── dataset2
├── gen
|   ├── analysis
|       ├── audit
|       ├── input
|       ├── output
|       ├── temp
|   ├── data-preparation      
|       ├── audit
|       ├── input
|       ├── output
|       ├── temp
|   ├── paper      
|       ├── audit
|       ├── input
|       ├── output
|       ├── temp
├── .gitignore
├── README.md
└── Makefile

```


The main aim of this to have a basic structure, which can be easily adjusted to use in an actual project.  In this example project, the following is done: 
1. Download and prepare data
2. Run some analysis
3. Present results in a final pdf generated

## Dependencies
Please follow the installation guides on http://tilburgsciencehub.com/.
- [R] (https://tilburgsciencehub.com/building-blocks/configure-your-computer/statistics-and-computation/r/)
- [Make] (https://tilburgsciencehub.com/building-blocks/configure-your-computer/automation-and-workflows/make/)

For R, make sure you have installed the following R packages:
'install.packages(“readr”)'
'install.packages(“dplyr”)'
'install.packages(“ggplot2”)'
'install.packages(“tidyverse”)'
'install.packages(“ggpubr”)'
'Install.packages(“car”)'
'install.packages(“scales”)'
'install.packages(“stargazer”)'

## Running instructions

All of the data, analysis and plots can be run using the main makefile. R will make sure the proper packages will be installed if necessary. To make the main makefile run, Windows OS users will have to install [Make](https://gnuwin32.sourceforge.net/packages/make.htm). For Mac and Linux OS users, this will automatically be installed.When Make is installed, it is possible to run the makefile in RStudio. 

First, type "make -n" in the Terminal. R wil then show you everything it will run. If you type in "make", R wil run all the code. This can take some time. When R is done, all the output will be generated.

## More resources

## About

This repository was created as a part of the Data Preparation and Workflow Managemant course in the Marketing Analytics Master of Tilburg University. The following students contributed to the creation of this repository:

* Fleur Le Mire
* Mariella Van Erve
* Nishtha Staice
* Yi Ting Tsai
* Hilal Nur Turer


## Notes
- `make clean` removes all unncessary temporary files. 
- Tested under Linux Mint (should work in any linux distro, as well as on Windows and Mac) 
- IMPORTANT: In `makefile`, when using `\` to split code into multiple lines, no space should follow `\`. Otherwise Gnu make aborts with error 193. 
- Many possible improvements remain. Comments and contributions are welcome!
