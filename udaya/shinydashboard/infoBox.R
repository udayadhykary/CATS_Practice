library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Creating and Rendering infoBox", titleWidth = 700),
  dashboardSidebar(
    sidebarMenu(
      menuItem("infoBox", tabName = "infobox")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "infobox",
        fluidRow(infoBoxOutput("min_", width = 3),
                 infoBoxOutput("max_", width = 3),
                 infoBoxOutput("sd_", width = 3),
                 infoBoxOutput("mean_", width = 3)),
        fluidRow(infoBoxOutput("median_", width = 6)),
        fluidRow(infoBoxOutput("inline"),
                 tags$style("#inline {height:75px; line-height:75px; 
      padding-top:0px; padding-bottom:0px; width:400px;}"))
      )
    )
  )
)

s <- sample(100:500, 50)


server <- function(input, output, session) {
  output$min_ <- renderInfoBox({
    infoBox(title = "Minm",
            value = min(s),
            subtitle = "minimum value in dataset",
            fill = TRUE)
  })


  output$max_ <- renderInfoBox({
    infoBox(title = "Maxm",
            value = max(s),
            subtitle = "maximum value in dataset", fill = TRUE,
            color = "yellow")

  })


  output$sd_ <- renderInfoBox({
    infoBox(title = "SD",
            value = round(sd(s), 2),
            subtitle = "Standard Deviation", icon("arrow-up"))

  })


  output$mean_ <- renderInfoBox({
    infoBox(title = "Mean",
            value = mean(s),
            subtitle = "Mean of dataset values",
            icon = icon("angle-double-right"))

  })


  output$median_ <- renderInfoBox({
    infoBox(title = tags$b("Median"),
            value = median(s),
            subtitle = tags$i("Median of dataset"),
            icon = icon("angle-double-right"))

  })

  output$inline <- renderInfoBox({
    infoBox(title = "Inline CSS", value = "Adjusted width and height")
  })

}

shinyApp(ui = ui, server = server)