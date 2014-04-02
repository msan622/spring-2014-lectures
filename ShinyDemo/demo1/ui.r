library(shiny)

# Create a simple shiny page.
shinyUI(
    # We will create a page with a sidebar for input.
    pageWithSidebar(
        # Add title panel.
        headerPanel("Movie Genres"),

        # Setup sidebar widgets.
        sidebarPanel(
            # Add a drop-down box for sort columns.
            selectInput(
                # This will be the variable we access later.
                "sortColumn",
                # This will be the control title.
                "Sort By:",
                # This will be the control choices.
                choices = c("Genre", "Count")
            ),

            # Add true/false checkbox for sorting.
            checkboxInput(
                "sortDecreasing",
                "Decreasing",
                FALSE
            ),

            # Add a little bit of space between widgets.
            br(),

            # Add radio buttons for selecting the color scheme.
            # Can only select one radio button at a time.
            radioButtons(
                "colorScheme",
                "Color Scheme:",
                c("None", "Qualitative 1", "Qualitative 2", "Color-Blind Friendly")
            ),

            # Add a download link
            HTML("<p align=\"center\">[ <a href=\"https://github.com/msan622/lectures/tree/master/ShinyDemo/demo1\">download source</a> ]</p>")
        ),

        # Setup main panel.
        mainPanel(
            # Create a tab panel.
            tabsetPanel(
                # Add a tab for displaying the histogram.
                tabPanel("Histogram", plotOutput("barPlot")),

                # Add a tab for displaying the table (will be sorted).
                tabPanel("Table", tableOutput("table"))
            )
        )
    )
)
