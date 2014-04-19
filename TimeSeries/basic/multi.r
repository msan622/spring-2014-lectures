require(ggplot2)

source("data.r")
source("pretty.r")

# CREATE BASE PLOT ####################
p <- ggplot(
    subset(molten, variable == "total"), 
    aes(
        x = month, 
        y = value, 
        group = year, 
        color = year
    )
)

# CREATE MULTI-LINE PLOT ##############
p <- p + geom_line(alpha = 0.8)
p <- p + scale_colour_brewer(palette = "Set1")

# make it pretty
p <- p + scale_months()
p <- p + scale_deaths()
p <- p + theme_legend()
p <- p + theme_guide()

# squarify grid (1 month to 1000 deaths)
# p <- p + coord_fixed(ratio = 1 / 1000)

# CREATE FACET PLOT ###################
# p <- p + facet_wrap(~ year, ncol = 2)
# p <- p + theme(legend.position = "none")

# CREATE STAR-LIKE PLOT ###############
# p <- p + coord_polar()

print(p)
