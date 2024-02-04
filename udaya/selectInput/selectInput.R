library(shiny)

####
## Test 1: Show the range of longitude latitude 
## Test 2: Show it on the map
####

data <- data.frame(
  Country = c("U.S.A", "U.K", "Taiwan", "Nepal", "Argentina"),
  Latitude_Range = c("25.84 - 49.38", "49 - 61", "21.7 - 26.4", "26 - 31", "-56.5 - -21"),
  Longitude_Range = c("-124.67 - -66.95", "-11 - 2.2", "118 - 122.3", "79.8 - 88.5", "-76.5 - -52.5")
)


ui<- fluidPage(
  titlePanel("Practicing selectInput widget in R Shiny"),
  sidebarLayout(
    sidebarPanel(
      selectInput("countries", "Select the country of your residency", choices = data$Country, selected = "Nepal")
    ),
    mainPanel(
      textOutput("country"),
      textOutput("latitude"),
      textOutput("longitude")

    )
  ))

server<- function(input,output){
  output$country <- renderText({
    paste("You are from", input$countries)
  })

  output$latitude <- renderText({
    selected_country <- data[data$Country == input$countries, ]
    paste("Latitude Range:", selected_country$Latitude_Range)
  })
  
  output$longitude <- renderText({
    selected_country <- data[data$Country == input$countries, ]
    paste("Longitude Range:", selected_country$Longitude_Range)
  })
  
}

shinyApp(ui= ui, server= server)