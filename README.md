# Airbnb New Year's Eve 

Welcome to our research project!

![image](https://user-images.githubusercontent.com/123902060/220652672-82bcdd9e-0f1a-4cfe-bdeb-f8dfcbed94f1.png)

## Motivation
In this study, the effect of New Year’s eve on Airbnb listings is analyzed across multiple capital cities in Europe. We chose the cities London, Paris, Amsterdam, and Rome in order to measure if New Year’s eve has a different influence per city on the Airbnb accommodations. Therefore, we will look at the price of the listings and the availability of airbnb’s, so the number of booked/not booked accommodations.

We chose New Year’s eve since it is a day that is celebrated across the world and happens each yar on the same date. We wanted to compare more cities throughout Europe, rather than just a few cities in the netherlands. Moreover, we also found it important that the cities are comparable in size/population, expensiveness etc so that this could not influence the results. Therefore, we decided to only choose a few capital cities in Europe. Another important part for choosing this event was that the data is available for before, during, and after the event which we checked before choosing this research and those specific cities.

### Research Question
*What is the effect of New Year’s eve on Airbnb listings in Capital cities in Europe?*

## Method and Results

### Method
Inside Airbnb provided the information needed for this research project. To analyze the effects of prices of Airbnb accommodations during a New Year's Eve in capital cities in Europe, we will use a linear regression analysis. Moreover, to analyze the effects of the bookings of Airbnb accommodations during a New Year's Eve in capital cities in Europe, we will use a logistic regression analysis. The analysis will be done in RStudio, since this program allows us for preparing and analyzing the data.

In order to conduct this study, we examined data beginning five days before New Year's Eve 2022 (December 26th) and ending five days after New Year's Eve 2022 (January 5th). To compare the impact of New Year's Eve with other, "regular" days, we made a dummy for New Year's Eve. For the analysis, we contrast London, Paris, Amsterdam, and Rome as these are four of Europe's big cities. This allows us to determine whether the city itself—such as the fact that it is a more popular city—does not have an impact on the prices and bookings of the Airbnb’s.

![Schermafbeelding 2023-03-16 om 10 29 14](https://user-images.githubusercontent.com/122876103/225574072-b0c7ef9a-4902-49b4-b79b-b41120d44531.png)

### Variables used in the study

| **Variable**  | **Description**                                                                       | **Data** |
| ------------- | ------------------------------------------------------------------------------------- | -------- |
| price         | The listing price of an Airbnb per night in dollars                                   | numeric  |
| booked        | Dummy variable: whether the accomodation is not booked (0) or it is booked (1)        | numeric  |
| newyearseve   | Dummy variable: whether it is not New Year's Eve (0) or it is (1) on that specific day| numeric  |
| city          | The city of the Airbnb listing (London, Paris, Amsterdam or Rome)                     | character|



To build a new dataset, the listing- and calendar datasets of Rome, Amsterdam, Londen and Paris, retrieved from insideairbnb, are combined. This new dataset is cleaned up and it is checked for relevant elements before analysis. These sets enable analysis for every listing for every specific day, allowing for price comparisons between dates. To supplement the calendar dataset with additional data, the listings dataset will be combined with it and this will be saved in a file with the name complete_data.csv. Moreover, the data per city will be saved seperately in a file with the name complete_data_cityname.csv. Analysis has been done by using RStudio. A linear regression analysis has be used with this cleaned-up dataset to analyze the effect onthe Airbnb prices. A logistic regression has been used to determine the effect of New Year's Eve on the bookings. 

### Results

**Price**: H1: New Year’s Eve influences the prices of Airbnb listings. 

The results show a P-value of <0.01 for both the complete model and the different cities separate. Therefore, with a significance of 0.05, the H0 can be rejected. Therefore, we can state that there is a significant relationship between New Year’s Eve and prices of Airbnb listings. The estimate of New Year's Eve is positive for the complete datasets and for the cities seperate. This means that we can concluded that prices will be higher during New Year's Eve. Moreover, it is striking that the prices of Airbnbs in Paris, London and Rome are comparable. On the other hand, prices in Amsterdam are significantly higher in the same timeperiod.

**Bookings**: H1: New Year’s Eve influences the amount of booked Airbnbs. 

The results from the logistic regression show a P-value<0.01 for both the complete model and the different cities seperate. Therefore, with a significance of 0.05, the null hypothesis can be rejected. By examining the exponents, we discovered that the impact across Paris, London, and Amsterdam is very similar, but they are all very different from Rome. The likelihood of an Airbnb being booked on New Year's Eve in Amsterdam increases by 0.692, in Paris increases by 0.451 and in London increases by 0.470. While these odds increase by 1.029 in Rome respectively. This demonstrates that the likelihood of booking an Airbnb on New Year’s Eve is the highest in Rome. 

## Conclusion

## Repository overview

The directory structure is as follow:
```
├── src
|   ├── analysis
|       ├── analyze.R
|       ├── Graphs.R
|       ├── update_input.R
|       ├── regression
|       ├── makefile
|   ├── data-preparation
|       ├── Data_exploration.R
|       ├── Install packages.R
|       ├── New_Years.Rmd
|       ├── clean_data.R
|       ├── download_data.R
|       ├── makefile
|   ├── paper
|       ├── paper.tex
|       ├── tables.R
|   ├── clean-up.R
├── gen
|   ├── analysis
|       ├── output
|       ├── temp
|   ├── data-preparation      
|       ├── output
|       ├── temp
|   ├── paper      
|       ├── output
|       ├── temp
├── .gitignore
├── README.md
└── makefile

```


The main aim of this to have a basic structure, which can be easily adjusted to use in an actual project.  In this example project, the following is done: 
1. Download and prepare data
2. Run some analysis
3. Present results in a final pdf generated

## Dependencies
- R 
- R packages: `install.packages("stargazer")`
- [Gnu Make](https://tilburgsciencehub.com/get/make) 
- [TeX distribution](https://tilburgsciencehub.com/get/latex/?utm_campaign=referral-short)
- For the `makefile` to work, R, Gnu make and the TeX distribution (specifically `pdflatex`) need to be made available in the system path 
- Detailed installation instructions can be found here: [tilburgsciencehub.com](http://tilburgsciencehub.com/)

## Running instructions

All of the data, analysis and plots can be run using the main makefile. R will make sure the proper packages will be installed if necessary. To make the main makefile run, Windows OS users will have to install [Make](https://gnuwin32.sourceforge.net/packages/make.htm). For Mac and Linux OS users, this will automatically be installed.When Make is installed, it is possible to run the makefile in RStudio. 

First, type "make -n" in the Terminal. R wil then show you everything it will run. If you type in "make", R wil run all the code. This can take some time. When R is done, all the output will be generated.

## More resources

## About

This repository was created as a part of the Data Preparation and Workflow Managemant course in the Marketing Analytics Master of Tilburg University. The following students contributed to the creation of this repository:

* Fleur Le Mire
* Mariëlla van Erve
* Nishtha Staice
* Yi Ting Tsai
* Hilal Nur Turer


## Notes
- `make clean` removes all unnecessary temporary files. 
- Tested under Linux Mint (should work in any linux distro, as well as on Windows and Mac) 
- IMPORTANT: In `makefile`, when using `\` to split code into multiple lines, no space should follow `\`. Otherwise Gnu make aborts with error 193. 
- Many possible improvements remain. Comments and contributions are welcome!
