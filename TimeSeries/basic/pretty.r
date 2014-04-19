# PRETTIFY PLOTS ############

# Scales --------------------

scale_year <- function() {
    return(
        scale_x_continuous(
            name = "Year",
            # using 1980 will result in gap
            limits = c(1974, 1979.917),
            expand = c(0, 0),
            # still want 1980 at end of scale
            breaks = c(seq(1974, 1979, 1), 1979.917),
            labels = function(x) {ceiling(x)}
        )
    )
}

scale_months <- function() {
    return(
        scale_x_discrete(
            name = "Month",
            expand = c(0, 0),
            # this is for faceting,
            # can be removed otherwise
            labels = fancy_label
        )
    )
}

scale_deaths <- function() {
    return (
        scale_y_continuous(
            name = "Deaths in Thousands",
            # set nice limits and breaks
            limits = c(0, 4000),
            expand = c(0, 0),
            breaks = seq(0, 4000, 1000),
            # reduce label space required
            labels = function(x) {paste0(x / 1000, 'k')}
        )    
    )
}

# FANCY PALETTE FOR HEATMAPS #######

# Uses discrete color scale for
# continuous gradient scale
scale_prgn <- function() {
    return(
        scale_fill_gradientn(
            colours = brewer_pal(
                type = "div", 
                palette = "PRGn")(5),
            name = "Deaths",
            limits = c(0, 4000),
            breaks = c(0, 2000, 4000)
        )
    )
}

# THEMES ####################

theme_heatmap <- function() {
    return (
        theme(
            axis.text.y = element_text(
                angle = 90,
                hjust = 0.5),
            axis.ticks = element_blank(),
            axis.title = element_blank(),
            legend.direction = "horizontal",
            legend.position = "bottom",
            panel.background = element_blank()
        )
    )
}

theme_legend <- function() {
    return(
        theme(
            legend.direction = "horizontal",
            legend.position = c(1, 1),
            legend.justification = c(1, 1),
            legend.title = element_blank(),
            legend.background = element_blank(),
            legend.key = element_blank()
        )
    )
}

theme_guide <- function() {
    options = list(size = 2)
    
    return(
        guides(
            colour = guide_legend(
                "year", 
                override.aes = options
            )
        )
    )
}

# FANCY LABELER FOR FACET PLOTS #######

# This code drops the first label if it
# is an odd numbered facet.

count <- 1
fancy_label <- function(x) {
    count <<- count + 1
    if (count %% 2 == 0) { return(x) }
    else { return(c("", x[2:12])) }
}

# I don't 100% guarantee that this works.