library(shiny)

####
## Test: create a table at the bottom. Add a button. When the button is clicked, save and push the information into the table.
####


shinyUI(fluidPage(
  
  titlePanel("Demonstration of shiny widgets"),
  sidebarLayout(
    sidebarPanel(("Enter the personal information"), 
                textInput("name", "Enter your name", ""),
                textInput("age", "Enter your age", ""), 
                radioButtons("gender", "Select your gender", list("Male", "Female"), "")),
    mainPanel(("Personal Information"),
          textOutput("myname"),
          textOutput("myage"),
          textOutput("mygender"))
  )
  
)
)
