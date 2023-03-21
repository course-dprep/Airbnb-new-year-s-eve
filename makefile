all: analysis data-preparation

data-preparation: 
		make -C src/data-preparation
		
analysis: data-preparation
		make -C src/analysis

clean:
		R -e "unlink('data/*.*')"
		R -e "unlink('gen/*.*', recursive = TRUE)"

paper: data-preparation 
		Rscript -e "rmarkdown::render('gen/paper/data_exploration.Rmd')"
		Rscript -e "rmarkdown::render("Report.Rmd")"
	