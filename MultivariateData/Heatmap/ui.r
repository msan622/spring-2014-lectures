library(shiny)
library(ggplot2)

data(iris)

# replace the period in the column names and use those
# as the sort choices in the ui
sortChoices <- gsub("\\.", " ", colnames(iris))

# this is using shiny version 0.9+
shinyUI(fluidPage(
    titlePanel("Iris Dataset"),
    plotOutput("heatmap"),
    div("Low values are green, mid values are white, and high values are purple.", align = "center"),
    wellPanel(fluidRow(
        column(6,
            sliderInput(
                "range",
                "Gradient Range:",
                min = 0,
                max = 1,
                value = c(0.45, 0.55),
                step = 0.05,
                format = "0.00",
                ticks = TRUE),
            br(),
            helpText(paste("This will control the",
                "middle break points for the color",
                "gradient. The selected range will",
                "become white."))
        ),
        column(3,
            radioButtons(
                "sort1",
                "Sort By:",
                sortChoices,
                selected = c("Species")
            )
        ),
        column(3,
            radioButtons(
                "sort2",
                "Sort By:",
                sortChoices,
                selected = c("Sepal Length")
            )
        )
    ))
))

