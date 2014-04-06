library(ggplot2)
library(reshape)
library(plyr)
library(scales)

# This is based on the following example:
# http://learnr.wordpress.com/2010/01/26/ggplot2-quick-heatmap-plotting/

# We need data in a long versus wide format (using melt) and in a
# format that we can sort rows. 
processData <- function(original) {
    # copy original dataset
    processed <- original
    
    # fix column names (replaces period with space)
    colnames(processed) <- gsub("\\.", " ", colnames(processed))
    
    # discard non-numeric data (optional)
    processed <- processed[sapply(processed, is.numeric)]

    # rescale all the values to [0, 1]
    processed <- rescaler(processed, type = "range")

    # melt dataset (convert from wide to long format)
    processed$id <- 1:nrow(original)
    processed <- melt(processed, "id")

    # convert id column into factor for sorting later
    processed$id <- factor(processed$id,
        levels = 1:nrow(original), 
        ordered = TRUE)

    return(processed)
}

# We will sort the melted dataset by changing the factor levels
# of the ID column. We need the order from the original dataset
# to figure out what the level order should be.
sortMelted <- function(original, melted, sort1, sort2) {
    # get sort order of original dataset
    sortOrder <- order(original[[sort1]], original[[sort2]])

    # sort melted dataframe by modifying factor levels
    melted$id <- factor(melted$id,
        levels = sortOrder, 
        ordered = TRUE)

    return(melted)
}

# This will generate a heatmap with a diversing color scheme and
# a certain middle region that will "fall to the background" by
# being set to white. This will increase the focus on very large 
# and very small values.
getHeatmap <- function(dataset, midrange) {
    # create base heatmap
    p <- ggplot(dataset, aes(x = id, y = variable))
    p <- p + geom_tile(aes(fill = value), colour = "white")
    p <- p + theme_minimal()
    
    # turn y-axis text 90 degrees (optional, saves space)
    p <- p + theme(axis.text.y = element_text(angle = 90, hjust = 0.5))

    # remove axis titles, tick marks, and grid
    p <- p + theme(axis.title = element_blank())
    p <- p + theme(axis.ticks = element_blank())
    p <- p + theme(panel.grid = element_blank())
    
    # remove legend (since data is scaled anyway)
    p <- p + theme(legend.position = "none")

    # remove padding around grey plot area
    p <- p + scale_x_discrete(expand = c(0, 0))
    p <- p + scale_y_discrete(expand = c(0, 0))    
    
    # optionally remove row labels (not useful depending on dataset)
    p <- p + theme(axis.text.x = element_blank())

    # get diverging color scale from colorbrewer
    # #008837 is green, #7b3294 is purple
    palette <- c("#008837", "#f7f7f7", "#f7f7f7", "#7b3294")
    
    if(midrange[1] == midrange[2]) {
        # use a 3 color gradient instead
        p <- p + scale_fill_gradient2(low = palette[1], mid = palette[2], high = palette[4], midpoint = midrange[1])
    }
    else {
        # use a 4 color gradient (with a swath of white in the middle)
        p <- p + scale_fill_gradientn(colours = palette, values = c(0, midrange[1], midrange[2], 1))
    }
    
    return(p)
}

# melt and process the iris data set and make it available
# globally by the shiny server
melted <- processData(iris)

# sorted <- sortMelted(iris, melted, 5, 2)
# print(getHeatmap(sorted, c(0.5, 0.5)))

shinyServer(function(input, output) {
    # operate on a local copy of the melted dataset
    # this way, each user has their own "view" and 
    # sort order in the dataset
    local <- melted
    
    # need the choice text used by the ui components
    choices <- gsub("\\.", " ", colnames(iris))

    # will reorder the dataset if the sort1 or 
    # sort2 values change in the ui
    reorderRows <- reactive({
        index1 <- which(choices == input$sort1)
        index2 <- which(choices == input$sort2)
        
        local <<- sortMelted(iris, local, index1, index2)
    })
    
    # will regenerate the heatmap any time one of the ui
    # elements are modified
    output$heatmap <- renderPlot({
        reorderRows()
        print(getHeatmap(local, input$range))
    })
})
