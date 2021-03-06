
library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Simulating Random Encounters in Population"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      wellPanel(
        sliderInput("N", "Total Number of Participants in Conference:", min = 10000, max = 100000, value = 40000, step = 10000), 
        br(),
        sliderInput("n", "Number of Active Personas:", min = 10, max = 200, value = 160, step = 10),
        tags$hr(),
        sliderInput("size", "Conference Area in sq ft.:", min = 100000, max = 3000000, value = 2600000, step = 100000),
        br(),
        sliderInput("iter", "Total Number of Hours to Simulate:", min = 1, max = 24, value = 4, step = 1),
        br(),
        sliderInput("x0", "Beacon Range (ft.):", min = 5, max = 100, value = 50, step = 5),
        tags$hr(),
        sliderInput("p_Move", "Percentage of population Actively Moving Around", min = 0.2, max = 1, value = 0.5, step = 0.1), 
        br(),
        actionButton("goButton", "Run!")
      )
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel(title = "Figure",
          tags$style(type='text/css', '#description {background-color: rgba(0,0,0,0); color: black; font-size: 22px}'),
          tags$style(type='text/css', '#figDescription {background-color: rgba(0,0,0,0); color: black; font-size: 22px}'),
          # tags$style(type='text/css', '#text1 {background-color: rgba(0,0,0,0); color: red; font-size: 22px}'),
          # tags$style(type='text/css', '#text2 {background-color: rgba(0,0,0,0); color: blue;font-size: 22px}'),
          plotOutput("encHist", width = "800px", height = "600px"), 
          htmlOutput("figDescription"),
          htmlOutput("description")
        ),
        tabPanel("About", includeMarkdown("About.md"))
      )
      #       htmlOutput("text1"),
      #       htmlOutput("text2")
    )
  )
))
