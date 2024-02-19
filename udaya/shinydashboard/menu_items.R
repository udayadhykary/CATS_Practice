library(shiny)
library(shinydashboard)
ui <- dashboardPage(
  dashboardHeader(title = "Practicing shinydashboard package - menuItem", titleWidth = 500),
  dashboardSidebar(
    
    sidebarMenu(
      
      menuItem(text = "About", tabName = "about", icon = icon("clipboard")),
      menuItem("Data", tabName = "data", icon = icon("database"), badgeLabel = "new", badgeColor = "green"),
      menuItem("Link to code files", href = "https://www.google.com", icon = icon("code"))
    )
  ),
  dashboardBody("This is the body of the dashbaord")
)

server <- function(input, output, session){
  
}

shinyApp(ui=ui, server=server)