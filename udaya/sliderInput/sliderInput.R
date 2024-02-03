
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
      textOutput("out2"),
      textOutput("out3"),
      textOutput("out4")
      
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
  
}

shinyApp(ui=ui, server=server)