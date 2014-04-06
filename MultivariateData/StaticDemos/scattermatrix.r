
# SCATTERPLOT MATRIX: IRIS DATASET
# http://www.inside-r.org/packages/cran/GGally/docs/ggpairs

# Load required packages
require(GGally)

# Load datasets
data(iris)

# Create scatterplot matrix
p <- ggpairs(iris, 
    # Columns to include in the matrix
    columns = 1:4,
    
    # What to include above diagonal
    # list(continuous = "points") to mirror
    # "blank" to turn off
    upper = "blank",
    
    # What to include below diagonal
    lower = list(continuous = "points"),
    
    # What to include in the diagonal
    diag = list(continuous = "density"),
    
    # How to label inner plots
    # internal, none, show
    axisLabels = "none",
    
    # Other aes() parameters
    colour = "Species",
    title = "Iris Scatterplot Matrix"
)

# Remove grid from plots along diagonal
for (i in 1:4) {
    # Get plot out of matrix
    inner = getPlot(p, i, i);
    
    # Add any ggplot2 settings you want
    inner = inner + theme(panel.grid = element_blank());

    # Put it back into the matrix
    p <- putPlot(p, inner, i, i);
}

# Show the plot
print(p)
