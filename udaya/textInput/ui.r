library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Demonstration of textInput in shiny!"),
  sidebarLayout(
    sidebarPanel(("Enter the personal information"), 
                textInput("name", "Enter your name", ""),
                textInput("age", "Enter your age", "")), 
    mainPanel(("Personal Information"),
          textOutput("myname"),
          textOutput("myage"))
  )
  
)
)
