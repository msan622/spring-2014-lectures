require(reshape2) # melt

# EXPLORE DATASET #####################

data(UKLungDeaths)
?UKLungDeaths

# is.ts(ldeaths)  # a time series
# str(ldeaths)    # deaths from 1974 to 1980
# print(ldeaths)  # prints in nice format
# View(ldeaths)   # but really just numbers

# EXTRACT DATASET #####################

# creates x-axis for time series
times <- time(ldeaths)

# note that 1/12 is approximately 0.0833
# note that february is 1974.083
print(times)

# extract years for grouping later
years <- floor(times)
years <- factor(years, ordered = TRUE)

# extract months by looking at time series cycle
cycle(times)        # 1 through 12 for each year
print(month.abb)    # month abbreviations

# store month abbreviations as factor
months <- factor(
    month.abb[cycle(times)],
    levels = month.abb,
    ordered = TRUE
)

# MOLTEN DATASET ######################

deaths <- data.frame(
    year   = years,
    month  = months,
    time   = as.numeric(times),
    total  = as.numeric(ldeaths),
    male   = as.numeric(mdeaths),
    female = as.numeric(fdeaths)
)

molten <- melt(
    deaths,
    id = c("year", "month", "time")
)

# todo: change time into Date object
