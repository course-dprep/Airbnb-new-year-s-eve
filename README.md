# Airbnb New Year's Eve 

Welcome to our research project! Our research aims to answer the following research question:

**What is the effect of New Year’s eve on Airbnb listings in Capital cities in Europe?**

We will look at the variables:
- Price
- Availability of airbnb’s

We chose the capital cities:
- London
- Paris
- Amsterdam
- Rome

## Motivation

## Method and Results
Inside Airbnb provided the information needed for this research project. In order to conduct this study, we examined data beginning two weeks before New Year's Eve 2022 (December 17) and ending two weeks after New Year's Eve 2022 (January 14th)???. To compare the impact of New Year's Eve with other, "regular" days, we made a dummy for the event. For the analysis, we contrast London, Paris, Amsterdam, and Rome—four of Europe's big cities. This allows us to determine whether the city itself—such as the fact that it is a more popular city—does not have an impact on the prices and availability of the Airbnb’s.


![image](https://user-images.githubusercontent.com/122876103/219945498-c7cecd56-56a0-4293-b8db-7a66a29415fe.png)

Possible research methods: 

•	t-test for prices

•	logistic regression for amount of bookings/availability of Airbnb’s

•	regression for both 

Possible variables: 

![image](https://user-images.githubusercontent.com/122876103/219945707-b1d39c4c-32af-409f-8796-d8b4500c7243.png)


In order to determine whether the variations in prices may be caused by the day of the week on which it is New Year’s Eve, we can additionally add a control variable (such as weekdays).

To build a new dataset, the listing and calendar datasets of insideairbnb are combined. This new dataset is cleaned up. Moreover, it is checked for relevant elements before analysis. These sets enable analysis for every listing for every specific day, allowing for price comparisons between dates. To supplement the calendar dataset with additional data, the listings dataset will be combined with it. Regression analysis can be used with this cleaned-up dataset to analyze data that is relevant to our research questions.

## Conclusion

## Repository overview


The main aim of this to have a basic structure, which can be easily adjusted to use in an actual project.  In this example project, the following is done: 
1. Download and prepare data
2. Run some analysis
3. Present results in a final pdf generated using LaTeX

## Dependencies
- R 
- R packages: `install.packages("stargazer")`
- [Gnu Make](https://tilburgsciencehub.com/get/make) 
- [TeX distribution](https://tilburgsciencehub.com/get/latex/?utm_campaign=referral-short)
- For the `makefile` to work, R, Gnu make and the TeX distribution (specifically `pdflatex`) need to be made available in the system path 
- Detailed installation instructions can be found here: [tilburgsciencehub.com](http://tilburgsciencehub.com/)

## Running instructions

## More resources

## About

## Notes
- `make clean` removes all unncessary temporary files. 
- Tested under Linux Mint (should work in any linux distro, as well as on Windows and Mac) 
- IMPORTANT: In `makefile`, when using `\` to split code into multiple lines, no space should follow `\`. Otherwise Gnu make aborts with error 193. 
- Many possible improvements remain. Comments and contributions are welcome!
