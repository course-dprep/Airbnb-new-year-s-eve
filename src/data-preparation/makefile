DATA = ../../data
TEMP = ../../gen/data-preparation/temp
EXPLORATION = ../../src/data-preparation


all: $(DATA)/listings-paris.csv.gz $(DATA)/calendar-paris.csv.gz $(DATA)/listings-rome.csv.gz $(DATA)/calendar-rome.csv.gz $(DATA)/listings-london.csv.gz $(DATA)/calendar-london.csv.gz $(DATA)/listings-amsterdam.csv.gz $(DATA)/calendar-amsterdam.csv.gz $(TEMP)/complete_data.csv $(EXPLORATION)/data_exploration.html
$(DATA)/listings-paris.csv.gz $(DATA)/calendar-paris.csv.gz $(DATA)/listings-rome.csv.gz $(DATA)/calendar-rome.csv.gz $(DATA)/listings-london.csv.gz $(DATA)/calendar-london.csv.gz $(DATA)/listings-amsterdam.csv.gz $(DATA)/calendar-amsterdam.csv.gz download_data.R
	R --vanilla < download_data.R
	
$(TEMP)/complete_data.csv: clean_data.R
	R --vanilla < clean_data.R
	
$(EXPLORATION)/data_exploration.html: NewYears.Rmd
	Rscript -e 'rmarkdown::render("New_Years.Rmd", output_format = "all")'
