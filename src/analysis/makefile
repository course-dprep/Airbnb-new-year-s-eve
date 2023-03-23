INPUT = ../../gen/data-preparation/output
OUTPUT = ../../gen/analysis/output
ANALYSIS = ../../src/analysis
CSV_FILES := $(wildcard $(INPUT)/complete_data_*.csv)

all: $(OUTPUT)/price_newyearseve_boxplot.pdf $(OUTPUT)/price_per_city_boxplot.pdf $(OUTPUT)/mean_price.RData $(OUTPUT)/model_results.RData $(OUTPUT)/booked_logistic.RData $(OUTPUT)/london_mean_price_graph $(OUTPUT)/paris_mean_price_graph $(OUTPUT)/ams_mean_price_graph $(OUTPUT)/rome_mean_price_graph $(OUTPUT)/mean_booked.RData $(ANALYSIS)/Report.pdf

$(OUTPUT)/mean_booked.RData $(OUTPUT)/booked_logistic.RData: $(INPUT)/complete_data.csv booked_analysis.R
		R --vanilla < booked_analysis.R

$(OUTPUT)/price_newyearseve_boxplot.pdf $(OUTPUT)/price_per_city_boxplot.pdf $(OUTPUT)/model_results.RData $(OUTPUT)/mean_price.RData $(OUTPUT)/london_mean_price_graph $(OUTPUT)/paris_mean_price_graph $(OUTPUT)/ams_mean_price_graph $(OUTPUT)/rome_mean_price_graph: $(INPUT)/complete_data.csv $(INPUT)/complete_data_*.csv price_analysis.R
		R --vanilla < price_analysis.R
	
$(ANALYSIS)/Report.pdf: $(OUTPUT)/price_newyearseve_boxplot.pdf $(OUTPUT)/price_per_city_boxplot.pdf $(OUTPUT)/model_results.RData $(OUTPUT)/booked_logistic.RData $(OUTPUT)/london_mean_price_graph $(OUTPUT)/paris_mean_price_graph $(OUTPUT)/ams_mean_price_graph $(OUTPUT)/rome_mean_price_graph Report.Rmd
		Rscript -e 'rmarkdown::render("Report.Rmd")'
