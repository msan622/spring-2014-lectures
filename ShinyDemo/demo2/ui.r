# This demo requires the latest development version of the
# shiny package. You can install the latest version using
# the devtools package.
# devtools::install_github("shiny", "rstudio")
library(shiny)

# The only difference from the last demo is the layout.
# https://github.com/rstudio/shiny/wiki/Shiny-Application-Layout-Guide

shinyUI(
    # Note the use of a different page type. Think of this
    # as a grid with rows and 12 columns.
    fluidPage(
        # These will take up the entire row.
        headerPanel("Movie Genres"),
        plotOutput("barPlot"),
        # Add an horizontal line divider.
        hr(),
        # If you want to specify columns, you need to first
        # explicitly create a row.
        fluidRow(
            # Now we can create a column, which can span
            # multiple columns (out of 12) if we want.
            column(
                # Number of columns to span.
                4,
                # Elements to place into this column.
                h4("Order Settings"),
                # Adds a panel with a grey background.
                wellPanel(
                    # Place inputs inside the panel.
                    selectInput(
                        "sortColumn",
                        "Sort By:",
                        choices = c("Genre", "Count")
                    ),
                    checkboxInput(
                        "sortDecreasing",
                        "Decreasing",
                        FALSE
                    )
                )
            ),
            column(
                4,
                h4("Color Settings"),
                wellPanel(
                    radioButtons(
                        "colorScheme",
                        "Color Scheme:",
                        c("None",
                          "Qualitative 1",
                          "Qualitative 2",
                          "Color-Blind Friendly")
                    )
                )
            ),
            column(
                4,
                h4("Data Table"),
                wellPanel(tableOutput("table"))
            )
        )
    )
)
