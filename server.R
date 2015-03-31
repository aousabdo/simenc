
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  pop <- reactive({
    DT <- simPop(N = input$N, n = input$n, a = sqrt(input$size), b = sqrt(input$size))
    return(DT)
  })
  
  output$encHist <- renderPlot({
    tmp <- totalEnc(DT = pop(), x0 = input$x0, iter = input$iter, p_Move = input$p_Move)
    hist(tmp, col = 'darkgray', border = 'white', main = "Distribution of Number of Encounters", xlab = "Number of Encounters")
  })
  
  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})
