library(shiny)

####
## Test: create a table at the bottom. Add a button. When the button is clicked, save and push the information into the table.
####


ui<- fluidPage(
  
  titlePanel("Demonstration of shiny widgets"),
  sidebarLayout(
    sidebarPanel(("Enter the personal information"), 
                textInput("name", "Enter your name", ""),
                numericInput("age", "Enter your age", ""), 
                radioButtons("gender", "Select your gender", list("Male", "Female"), ""),
                br(),
                actionButton("add","Add Information")),
    mainPanel(("Personal Information"),
          textOutput("myname"),
          textOutput("myage"),
          textOutput("mygender"),
          br(),
          tableOutput("info"))
  )
  
)

