library(shiny)

ui<- fluidPage(
  titlePanel("Practicing selectInput widget in R Shiny"),
  sidebarLayout(
    sidebarPanel(
      selectInput("countries", "Select the country of your residency", c("U.S.A", "U.K", "Taiwan","Nepal", "Argentina"), selected = "Nepal")
    ),
    mainPanel(
      textOutput("country")
    )
  ))

server<- function(input,output){
  output$country <- renderText(paste("You are from", input$countries))
  
}

shinyApp(ui= ui, server= server)