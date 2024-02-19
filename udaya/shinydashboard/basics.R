library(shiny)
library(shinydashboard)
ui <- dashboardPage(
  dashboardHeader(title = "Practicing shinydashboard package", titleWidth = 500),
  dashboardSidebar("This is a sidebar"),
  dashboardBody("This is the body of the dashbaord")
)

server <- function(input, output, session){
  
}

shinyApp(ui=ui, server=server)