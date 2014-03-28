library(shiny)

data(iris)

shinyUI(
    pageWithSidebar(
        headerPanel("Iris Data"),

        sidebarPanel(
            checkboxGroupInput(
                "highlight",
                "Iris Species",
                c("Setosa", "Versicolor", "Virginica"),
                selected = c("Setosa", "Versicolor", "Virginica")
            ),
            width = 2
        ),

        mainPanel(plotOutput("scatterplot"), width = 10)
    )
)
