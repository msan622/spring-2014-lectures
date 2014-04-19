require(ggplot2)

source("data.r")
source("pretty.r")

# CREATE BASE PLOT ####################
p <- ggplot(molten, aes(x = time, y = value))

# LINE CHART ##########################

# p <- p + geom_line(
#     data = subset(molten, variable == "total")
# )

# AREA CHART ##########################
p <- p + geom_area(
    data = subset(molten, variable != "total"),
    aes(
        group = variable,
        fill = variable,
        # not really necessary
        color = variable,
        # swap stacking order
        order = -as.numeric(variable)
    )
)

# make it pretty
p <- p + scale_year()
p <- p + scale_deaths()
p <- p + theme_legend()

# squarify grid (1 year to 1000 deaths)
p <- p + coord_fixed(ratio = 1 / 1000)

print(p)