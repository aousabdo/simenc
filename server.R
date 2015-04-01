library(shiny)

shinyServer(function(input, output) {
  
  pop <- reactive({
    DT <- simPop(N = input$N, n = input$n, a = sqrt(input$size), b = sqrt(input$size))
    return(DT)
  })
  
  output$encHist <- renderPlot({
    tmp <<- totalEnc(DT = pop(), x0 = input$x0, iter = input$iter, p_Move = input$p_Move)
    Histogram <<- hist(tmp, col = 'steelblue', border = 'white', main = "Distribution of Number of Encounters", 
                       xlab = "Number of Encounters")
    #     abline(v = median(tmp), col = "red", lwd = 3)
    #     abline(v = median(tmp[tmp != 0]), col = "blue", lwd = 3)
  })
  
  output$text1 <- renderUI({
    tmp <<- totalEnc(DT = pop(), x0 = input$x0, iter = input$iter, p_Move = input$p_Move)
    text1 <- paste("Median: ", median(tmp), sep = " ")
    HTML(text1)
  })
  
  output$text2 <- renderUI({
    tmp <<- totalEnc(DT = pop(), x0 = input$x0, iter = input$iter, p_Move = input$p_Move)
    text2 <- paste("Median (excluding zero encounters): ", median(tmp[tmp != 0]), sep = " ")
    HTML(text2)
  })
})
