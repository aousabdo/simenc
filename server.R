library(shiny)

shinyServer(function(input, output) {
  
  pop <- reactive({
    input$goButton
    DT <- simPop(N = input$N, n = input$n, a = sqrt(input$size), b = sqrt(input$size))
    return(DT)
  })
  
  output$encHist <- renderPlot({
    input$goButton
    tmp <- isolate(totalEnc(DT = pop(), x0 = input$x0, iter = input$iter, p_Move = input$p_Move))
    Histogram <- isolate(hist(tmp, col = 'steelblue', border = 'white', 
                       main = paste("Distribution of Total Number of Encounters After", input$iter,"hours", sep = " "), 
                       xlab = paste("Total Number of Encounters After", input$iter,"hours", sep = " "), 
                       cex.lab = 1.5, cex.axis = 1.5, cex.main = 1.5))
    #     abline(v = median(tmp), col = "red", lwd = 3)
    #     abline(v = median(tmp[tmp != 0]), col = "blue", lwd = 3)
  })
  
  output$figDescription <- renderUI({
    input$goButton
    figText <- paste("The figure above shows the distribution of the total number of encounters for simulated personas after the given
                     number of hours.")
    HTML(figText)
  })
  
  output$description <- renderUI({
    input$goButton
    tmp <- isolate(totalEnc(DT = pop(), x0 = input$x0, iter = input$iter, p_Move = input$p_Move))
    text0 <- isolate(paste0("<br>For a conference taking place in a square area of ", input$size,  " sq ft., where ", input$N, 
                            " people are present and out of which ", input$n, " are active participants, if we assume a beacon 
                            range of ", input$x0, " feet and assume that a random sample of size ", 100*input$p_Move, "% of the total population 
                            moves each hour, then for a total period of ", input$iter, " hours, we expect that, on average, each of our ",
                            input$n, " personas would have ", median(tmp)," encounters"))
    HTML(text0)
  })
  
    output$text1 <- renderUI({
    input$goButton
    tmp <- isolate(totalEnc(DT = pop(), x0 = input$x0, iter = input$iter, p_Move = input$p_Move))
    text1 <- paste("Median: ", median(tmp), sep = " ")
    HTML(text1)
  })
  
  output$text2 <- renderUI({
    input$goButton
    tmp <- isolate(totalEnc(DT = pop(), x0 = input$x0, iter = input$iter, p_Move = input$p_Move))
    text2 <- paste("Median (excluding zero encounters): ", median(tmp[tmp != 0]), sep = " ")
    HTML(text2)
  })
})
