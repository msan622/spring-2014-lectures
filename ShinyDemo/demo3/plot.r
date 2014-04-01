library(ggplot2)
library(shiny)
library(scales)

data("iris")
#View(iris)

# To improve output of items in legend, 
# easiest to modify original data.
# str(iris$Species)
capitalize <- function(text) {
    return(paste(
        toupper(substring(text, 1, 1)),
        substring(text, 2),
        sep = ""))
}

# Update the factor levels with new labels.
levels(iris$Species) <- sapply(
    levels(iris$Species),
    capitalize)

# Create base scatterplot.
p <- ggplot(iris, aes(x = Sepal.Length, 
                      y = Sepal.Width,
                      color = Species))

# Add better labels.
p <- p + xlab("Sepal Length")
p <- p + ylab("Sepal Width")
p <- p + ggtitle("Iris Data")
p <- p + labs(color = "Iris Species")

# Adjust x and y limits.
p <- p + xlim(4, 8)
p <- p + ylim(1, 5)

# Step 1: Adjust the size.
# Step 2: Add alpha and notice overplotting.
# Step 3: Add jitter to help with overplotting.
# Discussion: Which is more misleading?
p <- p + geom_point(size = 4,
                    alpha = 0.4,
                    position = "jitter")

# More playing around with theme options.
p <- p + theme(panel.background = element_rect(fill = NA))
p <- p + theme(legend.key = element_rect(fill = NA))

p <- p + theme(panel.border = element_rect(fill = NA, color = "grey60"))
p <- p + theme(panel.grid.major = element_line(color = "grey90"))
p <- p + theme(panel.grid.minor = element_line(color = "grey90", linetype = 3))

# Maybe remove plot outline but reduce plot padding
p <- p + scale_x_continuous(limits = c(4, 8), expand = c(0, 0))
p <- p + scale_y_continuous(limits = c(1, 5), expand = c(0, 0))
p <- p + theme(panel.border = element_blank())

# Maybe move legend onto plot area to save room
p <- p + theme(legend.direction = "horizontal")
p <- p + theme(legend.justification = c(0, 0))
p <- p + theme(legend.position = c(0, 0))
p <- p + theme(legend.background = element_blank())

# Set a specific aspect ratio
p <- p + coord_fixed(ratio = 1)

# Try to highlight only one species

# First get palette from color brewer
palette <- brewer_pal(type = "qual", palette = "Set1")(3)
species <- levels(iris$Species)
highlight <- c("Versicolor", "Virginica")

palette[which(!species %in% highlight)] <- "#EEEEEE"

p <- p + scale_color_manual(values = palette)

print(p)