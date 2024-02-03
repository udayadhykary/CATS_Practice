
library(shiny)

##
## Test 1: make plots to display your control
##


ui<- fluidPage(
  titlePanel("Practicing sliderInput widget in R Shiny"),
  sidebarLayout(
    sidebarPanel("Integer",
      sliderInput("slide1", "Select the value from Slider", min = 0, max=50, value=20, step=2),
      "Decimal",
      sliderInput("slide2", "Select the value from Slider", min = 0, max=5, value=2, step=0.2),
      "Range",
      sliderInput("slide3", "Select the value from Slider", min = 0, max=500, value=c(0,200), step=20),
      "Animate",
      sliderInput("slide4", "Select the value from Slider", min = 0, max=5, value=2, step=0.2, animate = TRUE)
      
    ),
    mainPanel(
      textOutput("out1"),
      plotOutput("plot1"),
      textOutput("out2"),
      plotOutput("plot2"),
      textOutput("out3"),
      plotOutput("plot3"),
      textOutput("out4"),
      plotOutput("plot4")
      
    )
    
  )
)
server<- function(input, output){
  
  output$out1 <- renderText(
    paste("You selected the value: ", input$slide1))
  output$out2 <- renderText(
    paste("You selected the value: ", input$slide2))
  output$out3 <- renderText(
    paste("You selected the value: ", input$slide3))
  output$out4 <- renderText(
    paste("You selected the value: ", input$slide4))

     ## renderPlot used 
  output$plot1 <- renderPlot({
    x <- input$slide1
    y <- sin(x)
    plot(x, y, type = "p", main = "Plot 1", xlab = "X", ylab = "Y")
  })
  
  output$plot2 <- renderPlot({
    x <- input$slide2
    y <- cos(x)
    plot(x, y, type = "p", main = "Plot 2", xlab = "X", ylab = "Y")
  })
  
  output$plot3 <- renderPlot({
    x <- input$slide3[2] - input$slide3[1]
    y <- x^2
    plot(x, y, type = "p", main = "Plot 3", xlab = "X", ylab = "Y")
  })
  
  output$plot4 <- renderPlot({
    x <- input$slide4
    y <- sqrt(x)
    plot(x, y, type = "p", main = "Plot 4", xlab = "X", ylab = "Y")
  })
  
  
}

shinyApp(ui=ui, server=server)