packages := readr dplyr ggplot2 tidyverse ggpubr car scales stargazer

all: analysis data-preparation

install:
	Rscript -e 'options(repos = "https://cloud.r-project.org"); source("Install_packages.R"); install.packages(c($(PACKAGES:%="%")))'

data-preparation: install
		make -C src/data-preparation
		
analysis: data-preparation
		make -C src/analysis

clean:
		R -e "unlink('data/*.*')"
		R -e "unlink('gen/*.*', recursive = TRUE)"

paper: data-preparation 
		Rscript -e "rmarkdown::render('gen/paper/data_exploration.Rmd')"
		Rscript -e "rmarkdown::render("Report.Rmd")"
	