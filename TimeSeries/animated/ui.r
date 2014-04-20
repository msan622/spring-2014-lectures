shinyUI(pageWithSidebar(
    headerPanel("UK Deaths from Lung Diseases"),
    
    sidebarPanel(
        sliderInput(
            "num", 
            "Months:", 
            min = 4, 
            max = 24,
            value = 12, 
            step = 1
        ),
        
        sliderInput(
            "start", 
            "Starting Point:",
            min = 1974, 
            max = 1980,
            value = 1974, 
            step = 1 / 12,
            round = FALSE, 
            ticks = TRUE,
            format = "####.##",
            animate = animationOptions(
                interval = 800, 
                loop = TRUE
            )
        ),
        
        width = 3
    ),
    
    mainPanel(
        plotOutput(
            outputId = "mainPlot", 
            width = "100%", 
            height = "400px"
        ),
        
        plotOutput(
            outputId = "overviewPlot",
            width = "100%",
            height = "200px"
        ),
        
        width = 9
    )
))