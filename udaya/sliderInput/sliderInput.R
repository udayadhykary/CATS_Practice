
library(shiny)

##
## Test 1: make plots to display your control
## Test 2: Show your values within only one plot. Make the plot meaningful.
##


ui<- fluidPage(
  titlePanel("Practicing sliderInput widget in R Shiny"),
  sidebarLayout(
    sidebarPanel("Integer",
      sliderInput("slide01", "Select the value from Slider", min = 0, max=50, value=20, step=2),
      "Decimal",
      sliderInput("slide02", "Select the value from Slider", min = 0, max=5, value=2, step=0.2),
      "Range",
      sliderInput("slide03", "Select the value from Slider", min = 0, max=500, value=c(0,200), step=20),
      "Animate",
      sliderInput("slide04", "Select the value from Slider", min = 0, max=5, value=2, step=0.2, animate = TRUE)
      
    ),
    mainPanel(
      textOutput("out01"),
      plotOutput("plot01"),
      textOutput("out02"),
      plotOutput("plot02"),
      textOutput("out03"),
      plotOutput("plot03"),
      textOutput("out04"),
      plotOutput("plot04")
      
    )
    
  )
)
server<- function(input, output){
  
  output$out01 <- renderText(
    paste("You selected the value: ", input$slide01))
  output$out02 <- renderText(
    paste("You selected the value: ", input$slide02))
  output$out03 <- renderText(
    paste("You selected the value: ", input$slide03))
  output$out04 <- renderText(
    paste("You selected the value: ", input$slide04))

     ## renderPlot used 
  output$plot01 <- renderPlot({
    x <- input$slide01
    y <- sin(x)
    plot(x, y, type = "p", main = "Plot 1", xlab = "X", ylab = "Y")
  })
  
  output$plot02 <- renderPlot({
    x <- input$slide02
    y <- cos(x)
    plot(x, y, type = "p", main = "Plot 2", xlab = "X", ylab = "Y")
  })
  
  output$plot03 <- renderPlot({
    x <- input$slide03[2] - input$slide03[1]
    y <- x^2
    plot(x, y, type = "p", main = "Plot 3", xlab = "X", ylab = "Y")
  })
  
  output$plot04 <- renderPlot({
    x <- input$slide04
    y <- sqrt(x)
    plot(x, y, type = "p", main = "Plot 4", xlab = "X", ylab = "Y")
  })
  
  
}

shinyApp(ui=ui, server=server)