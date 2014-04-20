
shinyServer(function(input, output) {
    output$mainPlot <- renderPlot({
        print(plotArea(input$start, input$num))
    })
    
    output$overviewPlot <- renderPlot({
        print(plotOverview(input$start, input$num))
    })
})
