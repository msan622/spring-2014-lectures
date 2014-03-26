library(ggplot2)
library(shiny)

# This script demonstrates the data and plot manipulations
# that we will use in the shiny app. Most of the code from
# this file will be moved into functions in the shiny server.

##### LOAD DATA #####

# Load the "movies" dataset.
data("movies", package = "ggplot2")

# Take a look at the dataset.
# View(movies)

# Figure out where the genre columns start.
start <- which(colnames(movies) == "Action")

# Figure out where the genre columns end.
end <- which(colnames(movies) == "Short")

# Get just the genre names.
genres <- colnames(movies)[start:end]

# Pre-allocate space for movie counts.
counts <- rep(0, length(genres))

# Calculate number of movies for each genre.
# I am sure there is a more "R" way to do this...
for(i in 1:length(genres)) {
    counts[i] <- sum(movies[, genres[i]])
}

# Combine into data frame
df <- data.frame(factor(genres), counts)

# Capitalize column names for better table output.
colnames(df) <- c("Genres", "Counts")

# Take a look at the new dataset.
# View(df)

##### SORT DATA #####

# Get desired order for rows.
sortOrder <- order(df$Genres, decreasing = TRUE)

# Re-order the x-axis. Since this is a FACTOR, we need to
# change the factor levels not the actual row order.
# print(df$Genres)
df$Genres <- factor(df$Genres, levels = df$Genres[sortOrder])
# print(df$Genres)

##### PLOT DATA #####

# Start building base plot.
p <- ggplot(df, aes(x = Genres, y = Counts, fill = Genres))
p <- p + geom_bar(stat = "identity")

##### LABEL CONFIG #####

# Lets change the labels.
p <- p + xlab("Movie Genre")
p <- p + ylab("Total Count")
p <- p + ggtitle("Movies by Genre")

# Changing legend involves setting label for the attribute
# that legend is showing (this case it is fill).
p <- p + labs(fill = "Movie Genres")

# Label formatter for numbers in thousands
thousand_formatter <- function(x) {
    #label <- round(x / 1000)
    return(sprintf("%dk", round(x / 1000)))
}

# Change how labels are shown.
p <- p + scale_y_continuous(
    # Changes how much plot area is expanded.
    expand = c(0, 500),
    # Specifies function to use to format labels.
    label = thousand_formatter)

p <- p + ylab("Count (in Thousands)")

##### THEME CONFIG #####

# Do we actually need so many labels?
p <- p + theme(axis.title.x = element_blank())
p <- p + theme(legend.position = "none")

# There are many other settings we can play with:
# http://docs.ggplot2.org/current/theme.html

p <- p + theme(panel.grid.major.x = element_blank())
p <- p + theme(panel.grid.minor.y = element_blank())
p <- p + theme(axis.ticks.x = element_blank())
p <- p + theme(axis.text.x = element_text(size = 12))

##### COLOR CONFIG #####

# This is not necessarily a good way to use color,
# but does demonstrate how to change color palettes.

# p <- p + scale_fill_brewer(type = "qual", palette = 1)
# p <- p + scale_fill_brewer(type = "qual", palette = 2)
# p <- p + scale_fill_grey(start = 0.4, end = 0.4)

# Color-blind friendly palette from http://jfly.iam.u-tokyo.ac.jp/color/
palette1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
p <- p + scale_fill_manual(values = palette1)

# Also, there are other themes for plot area.
# p <- p + theme_bw()

# Finally, show the plot.
print(p)
