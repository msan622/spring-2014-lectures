
# SMALL MULTIPLES PLOT: IRIS DATASET
# http://docs.ggplot2.org/current/facet_grid.html

# Load required packages
require(ggplot2)
require(reshape2) # melt(...)
require(grid)

# Load datasets
data(iris)

# Reformat dataset from wide to long format
df <- iris
df$id <- rownames(df)
df <- melt(df, id.vars = c("id", "Species"))

# Create labeler function that removes dots and
# capitalizes the first letter
niceLabels <- function(text) {
    text <- gsub("\\.", " ", text)
    text <- paste(
        toupper(substr(text, 1, 1)), 
        substring(text, 2),
        sep = "",
        collapse = "")
    return(text);
}

# Fix factor levels for better output in facet grid
levels(df$Species)  <- sapply(levels(df$Species), niceLabels)
levels(df$variable) <- sapply(levels(df$variable), niceLabels)

# Prepare small multiples plot
p <- ggplot(df, aes(x = value, group = variable, fill = Species)) +

    # Plot density
    geom_density(aes(colour = Species)) +

    # Split up data into individual plots for each
    # species versus variable type
    facet_grid(Species ~ variable,
        scales = "free_x") +
    
    # Modify facet scales
    scale_y_continuous(
        limits = c(0, 8),
        breaks = seq(4, 8, by = 4),
        expand = c(0, 0)) +

    # Tweak the theme
    theme(legend.position = "none") +
    theme(axis.title = element_blank()) +
    theme(panel.grid.minor.x = element_blank()) +
    theme(panel.grid.major.x = element_blank()) +
    labs(title = "Iris Small Multiples Plot")

# Show small multiples plot
print(p)
