library(shiny)
library(shinydashboard)
library(plotly)
library(datasets)

ui<- dashboardPage(
  dashboardHeader(title = "Practicing to create a box and styling it using shinydashboard package", titleWidth = 600),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("box",tabName = "box", icon = icon("check"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "box",
              fluidRow(box(title = "Creating a box with a plot", plotlyOutput("plot1",height = 250),
                           status = "danger", solidHeader = T, collapsible = T),
                       box(title = "Creating a box with a plot", plotlyOutput("plot2",height = 250))),
                    
              fluidRow(box(title = "Creating box with a datatable", tableOutput("data"),width = 6,
                           solidHeader = T, status = "success", background = "blue"),
                       box(title = "Creating box with input widget", uiOutput("inputwidget"),width = 4,
                           background = "black", solidHeader = T))
                       
              )
      
    )
  )
)


server <- function(input, output, session){
  
 output$data <- renderTable({
  head(mtcars)
})

output$plot1 <- renderPlotly({
  plot_ly(data = mtcars, x =~wt, y=~mpg, type = "scatter", mode= "markers")
})

output$plot2 <- renderPlotly({
  plot_ly(data = mtcars, x= ~mpg, type = "histogram")
})

output$inputwidget <- renderUI({
  selectInput(inputId = "in", "select a variable", choices = names(mtcars))
})

}

shinyApp(ui=ui, server = server)

