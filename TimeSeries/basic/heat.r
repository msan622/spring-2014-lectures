require(ggplot2)
require(grid)
require(scales)

source("data.r")
source("pretty.r")

# CREATE BASE PLOT ####################
p <- ggplot(
    subset(molten, variable == "total"), 
    aes(x = month, y = year)
)

p <- p + geom_tile(
    aes(fill = value), 
    colour = "white"
)

p <- p + scale_prgn()
p <- p + scale_months()
p <- p + scale_y_discrete(expand = c(0, 0))
p <- p + theme_heatmap()

# p <- p + coord_polar()
p <- p + coord_fixed(ratio = 1)

print(p)

# See also:
# http://stackoverflow.com/questions/13887365/ggplot2-circular-heatmap-that-looks-like-a-donut
