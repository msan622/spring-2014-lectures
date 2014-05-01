# Loads data frame, melts it, and then
# saves it as a CSV to load later.

require(reshape)
require(scales)

data(UKLungDeaths)

series <- as.numeric(time(ldeaths))
deaths <- as.numeric(ldeaths) 
male   <- as.numeric(mdeaths) 
female <- as.numeric(fdeaths)

lungdata <- data.frame(series, deaths, male, female)
lungmelt <- melt(lungdata, id = "series")

# get path (using appropriate separator for operating system)
path = file.path(".", "data", "lung.csv")

# write data to csv to load later
write.csv(lungmelt, path)

cat("Data saved to", path)