library(ggplot2)
library(shiny)
library(scales)

data("iris")

capitalize <- function(text) { return(paste(toupper(substring(text, 1, 1)), substring(text, 2), sep = "")) }
levels(iris$Species) <- sapply(levels(iris$Species), capitalize)

getPlot <- function(highlight) {
    p <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species))
    p <- p + geom_point(size = 4, alpha = 0.8, position = "jitter")
    
    p <- p + xlab("Sepal Length")
    p <- p + ylab("Sepal Width")
    p <- p + ggtitle("Iris Data")
    p <- p + labs(color = "Iris Species")
    
    p <- p + theme(panel.background = element_rect(fill = NA))
    p <- p + theme(legend.key = element_rect(fill = NA))
    p <- p + theme(panel.grid.major = element_line(color = "grey90"))
    p <- p + theme(panel.grid.minor = element_line(color = "grey90", linetype = 3))
    
    p <- p + scale_x_continuous(limits = c(4, 8), expand = c(0, 0))
    p <- p + scale_y_continuous(limits = c(1, 5), expand = c(0, 0))
    p <- p + theme(panel.border = element_blank())
    
    p <- p + theme(legend.direction = "horizontal")
    p <- p + theme(legend.justification = c(0, 0))
    p <- p + theme(legend.position = c(0, 0))
    p <- p + theme(legend.background = element_blank())
    
    p <- p + coord_fixed(ratio = 1)
    
    palette <- brewer_pal(type = "qual", palette = "Set1")(3)
    species <- levels(iris$Species)
    palette[which(!species %in% highlight)] <- "#EEEEEE"
    p <- p + scale_color_manual(values = palette)
    
    return(p)
}

shinyServer(function(input, output) {

    cat("Press \"ESC\" to exit...\n")

    # Choose what having no species selected should mean.
    getHighlight <- reactive({
        result <- levels(iris$Species)
#         if(length(input$highlight) == 0) {
#             return(result)
#         }
#         else {
            return(result[which(result %in% input$highlight)])
#         }
    })
    
    # Can control size if want
    output$scatterplot <- renderPlot(
      {
        print(getPlot(getHighlight()))
      }, 
      width = 600,
      height = 600)
})

# DISCUSSION:
# The points MOOOOOOOVE. Jitter is calculated when the plot
# is generated, and since it is random, everything you update
# the plot the points will move. To fix this, pre-jitter your 
# values, remove jittering, or choose a different way to deal
# with overplotting.
