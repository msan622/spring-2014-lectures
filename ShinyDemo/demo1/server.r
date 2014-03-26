library(ggplot2)
library(shiny)

# Objects defined outside of shinyServer() are visible to
# all sessions. Objects defined instead of shinyServer()
# are created per session. Place large shared data outside
# and modify (filter/sort) local copies inside shinyServer().

# See plot.r for more comments.

# Note: Formatting is such that code can easily be shown
# on the projector.

# Loads global data to be shared by all sessions.
loadData <- function() {
    data("movies", package = "ggplot2")

    start <- which(colnames(movies) == "Action")
    end <- which(colnames(movies) == "Short")
    genres <- colnames(movies)[start:end]
    counts <- rep(0, length(genres))

    for(i in 1:length(genres)) {
        counts[i] <- sum(movies[, genres[i]])
    }

    df <- data.frame(factor(genres), counts)
    colnames(df) <- c("Genres", "Counts")

    return(df)
}

# Label formatter for numbers in thousands.
thousand_formatter <- function(x) {
    return(sprintf("%dk", round(x / 1000)))
}

# Create plotting function.
getPlot <- function(localFrame, sortOrder, colorScheme = "None") {
    # Figure out sort order.
    localFrame$Genres <- factor(
        localFrame$Genres,
        levels = localFrame$Genres[sortOrder])

    # Create base plot.
    localPlot <- ggplot(localFrame, aes(x = Genres, y = Counts, fill = Genres)) +
        geom_bar(stat = "identity") +
        scale_y_continuous(expand = c(0, 500), label = thousand_formatter) +
        theme(legend.position = "none") +
        theme(panel.grid.major.x = element_blank()) +
        theme(panel.grid.minor.y = element_blank()) +
        theme(axis.ticks.x = element_blank()) +
        theme(axis.text.x = element_text(size = 12)) +
        theme(axis.title.x = element_blank()) +
        ggtitle("Movies by Genre")

    if (colorScheme == "Qualitative 1") {
        localPlot <- localPlot +
            scale_fill_brewer(type = "qual", palette = 1)
    }
    else if (colorScheme == "Qualitative 2") {
        localPlot <- localPlot +
            scale_fill_brewer(type = "qual", palette = 2)
    }
    else if (colorScheme == "Color-Blind Friendly") {
        localPlot <- localPlot +
            scale_fill_manual(values = palette1)
    }
    else {
        localPlot <- localPlot +
            scale_fill_grey(start = 0.4, end = 0.4)
    }

    return(localPlot)
}

##### GLOBAL OBJECTS #####

# Shared data
globalData <- loadData()

# Color-blind friendly palette from http://jfly.iam.u-tokyo.ac.jp/color/
palette1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
    "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

##### SHINY SERVER #####

# Create shiny server. Input comes from the UI input
# controls, and the resulting output will be displayed on
# the page.
shinyServer(function(input, output) {

    cat("Press \"ESC\" to exit...\n")

    # Copy the data frame (don't want to change the data
    # frame for other viewers)
    localFrame <- globalData

    # Output row order based on sorting criteria
    # Should update every time the sort column or descending
    # checkbox is changed. (Explain reactive functions.)
    sortOrder <- reactive(
        {
            if (input$sortColumn == "Genre") {
                return(
                    order(
                        localFrame$Genres,
                        decreasing = input$sortDecreasing
                    )
                )
            }
            else {
                return(
                    order(
                        localFrame$Counts,
                        decreasing = input$sortDecreasing
                    )
                )
            }
        }
    )

    # Output sorted table.
    # Should update every time sort order updates.
    output$table <- renderTable(
        {
            return(localFrame[sortOrder(), ])
        },
        include.rownames = FALSE
    )

    # Output sorted bar plot.
    # Should update every time sort or color criteria changes.
    output$barPlot <- renderPlot(
        {
            # Use our function to generate the plot.
            barPlot <- getPlot(
                localFrame,
                sortOrder(),
                input$colorScheme
            )

            # Output the plot
            print(barPlot)
        }
    )
})

# Two ways to run this application. Locally, use:
# runApp()

# To run this remotely, use:
# runGitHub("lectures", "msan622", subdir = "ShinyDemo/demo1")
