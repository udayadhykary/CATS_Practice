
library(shiny)

##
## Test 1: make plots to display your control
## Test 2: Show your values within only one plot. Make the plot meaningful.
##


ui<- fluidPage(
  titlePanel("Practicing sliderInput widget in R Shiny"),
  sidebarLayout(
    sidebarPanel("Integer",
      sliderInput("slide11", "Select the value from Slider", min = 0, max=50, value=20, step=2),
      "Decimal",
      sliderInput("slide21", "Select the value from Slider", min = 0, max=5, value=2, step=0.2),
      "Range",
      sliderInput("slide31", "Select the value from Slider", min = 0, max=500, value=c(0,200), step=20),
      "Animate",
      sliderInput("slide41", "Select the value from Slider", min = 0, max=5, value=2, step=0.2, animate = TRUE)
      
    ),
    mainPanel(
      textOutput("out11"),
      plotOutput("plot11"),
      textOutput("out21"),
      plotOutput("plot21"),
      textOutput("out31"),
      plotOutput("plot31"),
      textOutput("out41"),
      plotOutput("plot41")
      
    )
    
  )
)
server<- function(input, output){
  
  output$out31 <- renderText(
    paste("You selected the value: ", input$slide1))
  output$out32 <- renderText(
    paste("You selected the value: ", input$slide2))
  output$out33 <- renderText(
    paste("You selected the value: ", input$slide3))
  output$out34 <- renderText(
    paste("You selected the value: ", input$slide4))

     ## renderPlot used 
  output$plot1 <- renderPlot({
    x <- input$slide31
    y <- sin(x)
    plot(x, y, type = "p", main = "Plot 1", xlab = "X", ylab = "Y")
  })
  
  output$plot2 <- renderPlot({
    x <- input$slide32
    y <- cos(x)
    plot(x, y, type = "p", main = "Plot 2", xlab = "X", ylab = "Y")
  })
  
  output$plot3 <- renderPlot({
    x <- input$slide3[2] - input$slide33[1]
    y <- x^2
    plot(x, y, type = "p", main = "Plot 3", xlab = "X", ylab = "Y")
  })
  
  output$plot4 <- renderPlot({
    x <- input$slide34
    y <- sqrt(x)
    plot(x, y, type = "p", main = "Plot 4", xlab = "X", ylab = "Y")
  })
  
  
}

shinyApp(ui=ui, server=server)