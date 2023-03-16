DATA = ../../data
OUTPUT = ../../gen/data-preparation/output

all: $(OUTPUT)/complete_data.csv $(OUTPUT)/complete_data_%.csv $(DATA)/listings-%.csv.gz $(DATA)/calendar-%.csv.gz

$(OUTPUT)/complete_data.csv $(OUTPUT)/complete_data_%.csv: $(DATA)/listings-%.csv.gz $(DATA)/calendar-%.csv.gz clean_data.R
	R --vanilla < clean_data.R
	
$(DATA)/listings-%.csv.gz $(DATA)/calendar-%.csv.gz: download_data.R
	R --vanilla < download_data.R