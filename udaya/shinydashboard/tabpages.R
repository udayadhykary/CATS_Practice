library(shiny)
library(shinydashboard)
ui <- dashboardPage(
  dashboardHeader(title = "Practicing shinydashboard package - create tabpages", titleWidth = 500),
  dashboardSidebar(
    
    sidebarMenu(
      
      menuItem(text = "About", tabName = "about", icon = icon("clipboard")),
      menuItem("Data", tabName = "data", icon = icon("database"), badgeLabel = "new", badgeColor = "green"),
      menuItem("Link to code files", href = "https://www.google.com", icon = icon("code"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "about", p("This demonstrates layout of R shinydashboard package"),p("mtcars dataset was used")),
      tabItem(tabName = "data", dataTableOutput("mydata"))
    )
  )
)

server <- function(input, output, session){
  
  output$mydata <- renderDataTable({
      mtcars
  })
  
}

shinyApp(ui=ui, server=server)