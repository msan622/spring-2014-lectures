library(ggplot2)
library(grid)

data("iris")

# Sort bubble plot so smaller colors are displayed last
# on top of the bigger colors
df <- iris
df <- df[order(df$Petal.Length, decreasing = TRUE),]

# Create bubble plot
p <- ggplot(df, aes(
    x = Sepal.Length,
    y = Sepal.Width,
    color = Species,
    size = Petal.Length))

# Give points some alpha to help with overlap/density
# Can also "jitter" to reduce overlap but reduce accuracy
p <- p + geom_point(alpha = 0.6, position = "jitter")

# Default size scale is by radius, force to scale by area instead
# Optionally disable legends
p <- p + scale_size_area(max_size = 10, guide = "none")
# p <- p + scale_color_discrete(guide = "none")

# Tweak the plot limits
p <- p + scale_x_continuous(
    limits = c(3, 9),
    expand = c(0, 0))

p <- p + scale_y_continuous(
    limits = c(1, 5),
    expand = c(0, 0))

# Make the grid square
p <- p + coord_fixed(ratio = 1)

# Modify the labels
p <- p + ggtitle("Iris Dataset")
p <- p + labs(
    size = "Petal Length",
    x = "Sepal Length",
    y = "Sepal Width")

# Modify the legend settings
p <- p + theme(legend.title = element_blank())
p <- p + theme(legend.direction = "horizontal")
p <- p + theme(legend.position = c(0, 0))
p <- p + theme(legend.justification = c(0, 0))
p <- p + theme(legend.background = element_blank())
p <- p + theme(legend.key = element_blank())
p <- p + theme(legend.text = element_text(size = 12))
p <- p + theme(legend.margin = unit(0, "pt"))

# Force the dots to plot larger in legend
p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))

# Indicate size is petal length
p <- p + annotate(
    "text", x = 6, y = 4.8,
    hjust = 0.5, color = "grey40",
    label = "Circle area is proportional to petal length.")

print(p)
