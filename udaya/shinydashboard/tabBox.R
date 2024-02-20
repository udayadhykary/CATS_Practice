library(shiny)
library(shinydashboard)
library(plotly)
library(datasets)

ui <- dashboardPage(
  dashboardHeader(title = "Practicing to create tab box in R Shiny", titleWidth = 700),
  dashboardSidebar(
    sidebarMenu(
      menuItem("tabBox", tabName = "charts", icon = icon("check"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "charts",
              fluidRow(tabBox(id = "tabchart1",
                              tabPanel("tab1",plotlyOutput("plot1")),
                              tabPanel("tab2",plotlyOutput("plot2")),
                              tabPanel("tab3",plotlyOutput("plot3"))),
                       
                       tabBox(id = "tabchart2",side = "right",
                              tabPanel("tab1","tab 1 content"),
                              tabPanel("tab2","tab 2 content"),
                              tabPanel("tab3","tab 3 content"))     
              ))
    )
  )
)

server <- function(input, output, session){
  
  output$plot1 <- renderPlotly({
    plot_ly(data = mtcars,
            x = ~wt,
            y = ~mpg,
            type = "scatter",
            mode = "markers")
  })
  
  output$plot2 <- renderPlotly({
    plot_ly(data = mtcars,
            x = ~hp,
            y = ~mpg,
            type = "scatter",
            mode = "markers")
  })
  
  output$plot3 <- renderPlotly({
    plot_ly(data = mtcars, x = ~mpg, type = "histogram")
  }) 
}

shinyApp(ui = ui, server = server)