
# PARALLEL COORDINATE PLOT: IRIS DATASET
# http://www.inside-r.org/packages/cran/GGally/docs/ggparcoord
# http://docs.ggplot2.org/current/scale_size_area.html
# http://docs.ggplot2.org/current/geom_jitter.html

# Load required packages
require(GGally)

# Load datasets
data(iris)

# Generate basic parallel coordinate plot
p <- ggparcoord(data = iris, 
                
                # Which columns to use in the plot
                columns = 1:4, 
                
                # Which column to use for coloring data
                groupColumn = 5, 
                
                # Allows order of vertical bars to be modified
                order = "anyClass",
                
                # Do not show points
                showPoints = FALSE,
                
                # Turn on alpha blending for dense plots
                alphaLines = 0.6,
                
                # Turn off box shading range
                shadeBox = NULL,
                
                # Will normalize each column's values to [0, 1]
                scale = "uniminmax" # try "std" also
)

# Start with a basic theme
p <- p + theme_minimal()

# Decrease amount of margin around x, y values
p <- p + scale_y_continuous(expand = c(0.02, 0.02))
p <- p + scale_x_discrete(expand = c(0.02, 0.02))

# Remove axis ticks and labels
p <- p + theme(axis.ticks = element_blank())
p <- p + theme(axis.title = element_blank())
p <- p + theme(axis.text.y = element_blank())

# Clear axis lines
p <- p + theme(panel.grid.minor = element_blank())
p <- p + theme(panel.grid.major.y = element_blank())

# Darken vertical lines
p <- p + theme(panel.grid.major.x = element_line(color = "#bbbbbb"))

# Move label to bottom
p <- p + theme(legend.position = "bottom")

# Figure out y-axis range after GGally scales the data
min_y <- min(p$data$value)
max_y <- max(p$data$value)
pad_y <- (max_y - min_y) * 0.1

# Calculate label positions for each veritcal bar
lab_x <- rep(1:4, times = 2) # 2 times, 1 for min 1 for max
lab_y <- rep(c(min_y - pad_y, max_y + pad_y), each = 4)

# Get min and max values from original dataset
lab_z <- c(sapply(iris[, 1:4], min), sapply(iris[, 1:4], max))

# Convert to character for use as labels
lab_z <- as.character(lab_z)

# Add labels to plot
p <- p + annotate("text", x = lab_x, y = lab_y, label = lab_z, size = 3)

# Display parallel coordinate plot
print(p)