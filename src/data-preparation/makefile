DATA = ../../data
OUTPUT = ../../gen/data-preparation/output


all: $(OUTPUT)/complete_data.csv $(OUTPUT)/complete_data_london.csv $(OUTPUT)/complete_data_paris.csv $(OUTPUT)/complete_data_ams.csv $(OUTPUT)/complete_data_rome.csv $(DATA)/listings-paris.csv.gz $(DATA)/calendar-paris.csv.gz $(DATA)/listings-rome.csv.gz $(DATA)/calendar-rome.csv.gz $(DATA)/listings-london.csv.gz $(DATA)/calendar-london.csv.gz $(DATA)/listings-amsterdam.csv.gz $(DATA)/calendar-amsterdam.csv.gz $(OUTPUT)/complete_data.csv $(OUTPUT)/complete_data_london.csv $(OUTPUT)/complete_data_paris.csv $(OUTPUT)/complete_data_ams.csv $(OUTPUT)/complete_data_rome.csv

$(OUTPUT)/complete_data.csv $(OUTPUT)/complete_data_london.csv $(OUTPUT)/complete_data_paris.csv $(OUTPUT)/complete_data_ams.csv $(OUTPUT)/complete_data_rome.csv: $(DATA)/listings-paris.csv.gz $(DATA)/calendar-paris.csv.gz $(DATA)/listings-rome.csv.gz $(DATA)/calendar-rome.csv.gz $(DATA)/listings-london.csv.gz $(DATA)/calendar-london.csv.gz $(DATA)/listings-amsterdam.csv.gz $(DATA)/calendar-amsterdam.csv.gz clean_data.R
	R --vanilla < clean_data.R
	
$(DATA)/listings-paris.csv.gz $(DATA)/calendar-paris.csv.gz $(DATA)/listings-rome.csv.gz $(DATA)/calendar-rome.csv.gz $(DATA)/listings-london.csv.gz $(DATA)/calendar-london.csv.gz $(DATA)/listings-amsterdam.csv.gz $(DATA)/calendar-amsterdam.csv.gz: download_data.R
	R --vanilla < download_data.R



