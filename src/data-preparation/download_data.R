# DOWNLOAD DATA 

# Create data directory
dir.create('./data/data_newyearseve')

# Avoid downloading timeout #
options(timeout = max(1000, getOption("timeout")))

# Downloading the files from Inside Aibnb #
files = list(c(url='http://data.insideairbnb.com/united-kingdom/england/london/2022-12-10/data/listings.csv.gz',
               fn ='listings-london.csv.gz'),
             c(url='http://data.insideairbnb.com/united-kingdom/england/london/2022-12-10/data/calendar.csv.gz',
               fn='calendar-london.csv.gz'),
             c(url ='http://data.insideairbnb.com/france/ile-de-france/paris/2022-12-10/data/listings.csv.gz',
               fn='listings-paris.csv.gz'),
             c(url='http://data.insideairbnb.com/france/ile-de-france/paris/2022-12-10/data/calendar.csv.gz',
               fn='calendar-paris.csv.gz'),
             c(url='http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2022-12-05/data/listings.csv.gz',
               fn='listings-amsterdam.csv.gz'),
             c(url='http://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2022-12-05/data/calendar.csv.gz',
               fn='calendar-amsterdam.csv.gz'),
             c(url='http://data.insideairbnb.com/italy/lazio/rome/2022-12-13/data/listings.csv.gz',
               fn='listings-rome.csv.gz'),
             c(url='http://data.insideairbnb.com/italy/lazio/rome/2022-12-13/data/calendar.csv.gz',
               fn='calendar-rome.csv.gz'))

for (item in files) {
  download.file(item['url'], paste0('./data/data_newyearseve', item['fn']))}
