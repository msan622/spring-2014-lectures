library(shiny)
library(ggplot2)

data(iris)

sortChoices <- gsub("\\.", " ", colnames(iris))

shinyUI(fluidPage(
    titlePanel("Iris Dataset"),
    plotOutput("heatmap"),
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

