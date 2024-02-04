library(shiny)

server <- function(input,output){

  info_data <- reactiveValues(info = data.frame(Name = character(),
                                                  Age = numeric(),
                                                  Gender = character()))
    
    observeEvent(input$add, {
      name <- input$name
      age <- input$age
      gender <- input$gender
      info_data$info <- rbind(info_data$info, data.frame(Name = name, Age = age, Gender = gender))
      
    })
    
    
    output$info <- renderTable({info_data$info})
    output$myname <- renderText( input$name)
    output$myage <- renderText( input$age)
    output$mygender <- renderText( input$gender)
  }
