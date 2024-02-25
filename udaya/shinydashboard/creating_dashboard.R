library(shiny)
library(shinydashboard)

ui <- dashboardPage(title = "Practicing", skin = "red",
      dashboardHeader(title = "Let's see what I can build in R Shinydashboard", titleWidth = 450,
                      dropdownMenu(type = "message",
                                   messageItem(from = "Finance Update",message = "We are low on budget", icon = icon("dollar"), time = "8:00 AM"),
                                   messageItem(from = "Sales Update", message = "All materials are sold", icon = icon("bar-chart"), time = Sys.time())
                                   ),
                      dropdownMenu(type = "notifications",
                                   notificationItem(
                                     text = "What are the current updates?",
                                     icon = icon("cloud-upload"),
                                     status = "warning"
                                   )),
                      dropdownMenu(type = "tasks",
                                   taskItem(
                                     value = 50,
                                     color = "red",
                                     "Learning the Shinydashboard")
                                   )
                      ),
      dashboardSidebar(
        sidebarMenu(
          sidebarSearchForm("text", "search", "Search"),
          menuItem("Dashboard", tabName = "dash", icon = icon("dashboard")),
            menuSubItem("Dashboard Finance", tabName = "fin"),
            menuSubItem("Dashboard Sales", tabName = "sal"),
          menuItem("Detailed Analysis", badgeLabel = "New", badgeColor = "green"),
          menuItem("Raw Data")
        )
      ),
      dashboardBody(
        tabItems(
          tabItem(tabName = "dash",
                  fluidRow(
                    column(width = 8,
                    infoBox("Sales",10000, icon = icon("check-square")),
                    infoBoxOutput("aprsales")
                    )
                  ),
                  
                  fluidRow(
                    valueBox(15*100000, "Amount to give salary to staff", icon = icon("exchange")),
                    valueBoxOutput("req")
                  ),
                  
                  fluidRow(
                    box(title = "Histogram of Faithful data",status = "primary", solidHeader = T, background = "aqua", plotOutput("histo")),
                    box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                        sliderInput("bins","Enter the no. of bins: ", min = 1, max = 100, value = 50),
                        br(),
                        textInput("text_input", "Search Something", ""))
                  )),
          tabItem(tabName = "fin",
                  h1("This is the finance dashboard")),
          tabItem(tabName = "sal",
                  h1("This is the sales dashboard"))
        )
        
      )
)

server <- function(input, output){
  
  output$histo <- renderPlot({
    hist(faithful$eruptions, breaks = input$bins)
  })
  
  output$aprsales <- renderInfoBox({
    infoBox("Approved Sales", "1,00,000", icon = icon("info"))
  })
  
  output$req <- renderValueBox({
    valueBox(15*10, "New Orders", icon = icon("bookmark"))
  })

}

shinyApp(ui = ui, server = server)