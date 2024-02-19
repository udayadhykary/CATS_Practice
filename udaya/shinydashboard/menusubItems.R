library(shiny)
library(shinydashboard)
ui <- dashboardPage(
  dashboardHeader(title = "Practicing shinydashboard package - adding sub menu items", titleWidth = 500),
  dashboardSidebar(
    
    sidebarMenu(id = "sidebarmenu",
      
      menuItem("Dashboard", tabName = "Dashboard", icon = icon("dashboard")),
      
      menuItem("chart", icon = icon("line-chart"),
               menuSubItem("chartmenusub1", tabName = "chart1", icon = icon("line-chart")),
               menuSubItem("chartmenusub2", tabName = "chart2", icon = icon("line-chart")))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("Dashboard", "This is the Dashboard tab page"),
      tabItem("chart1", "This is the chart1 tab page"),
      tabItem("chart2", "This is the chart2 tab page")
    )
    )
  )

server <- function(input, output, session){
  
}

shinyApp(ui=ui, server=server)