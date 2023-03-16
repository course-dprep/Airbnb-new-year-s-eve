INPUT = ../../gen/data-preparation/output
OUTPUT = ../../gen/analysis/output
ANALYSIS = ../src/analysis/

all: $(OUTPUT)/model_results.RData $(INPUT)/complete_data.csv $(INPUT)/complete_data_london.csv $(INPUT)/complete_data_paris.csv $(INPUT)/complete_data_ams.csv $(INPUT)/complete_data_rome.csv 

$(OUTPUT)/model_results.RData: analyzeR
		R --vanilla < analyze.R
	
$(INPUT)/complete_data.csv $(INPUT)/complete_data_london.csv $(INPUT)/complete_data_paris.csv $(INPUT)/complete_data_ams.csv $(INPUT)/complete_data_rome.csv: analyze.R
		R --vanilla < analyze.R

#need to add this still     
#$(ANALYSIS)/analysis.pdf : analysis.Rmd
        #Rscript -e 'rmarkdown::render("analysis.Rmd")'