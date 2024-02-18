library(shiny)
library(rhandsontable)
ui <- fluidPage(
  
    titlePanel(title = "Practicing cell change event demo "),
    hr(),
    fluidRow(column(5, rHandsontableOutput("table"), offset = 1),column(5, verbatimTextOutput("changeinfo"), offset = 1))
  )


a = sample(1:20, replace = TRUE)
b = sample(21:40, replace = TRUE)
c = a+b
d = b-a
df1 = data.frame(a=a, b=b, c=c, d=d)

server <- function(input,output,session){
  
  
  output$table <- renderRHandsontable({ 
    rhandsontable(df1)
  })
  
  observeEvent(input$table$changes$changes,
               {
                 xi=input$table$changes$changes[[1]][[1]] 
                 yi=input$table$changes$changes[[1]][[2]] 
                 old = input$table$changes$changes[[1]][[3]] 
                 new = input$table$changes$changes[[1]][[4]] 
                 
                 
                 output$changeinfo <- renderPrint({
                   
                   list(paste("Row index of cell which is changed", xi),
                        paste("Column index of cell which is changed", yi),
                        paste("Old value of the cell", old),
                        paste("New value of the cell", new))
                 })
               }
              )
  
            }

shinyApp(ui =ui, server = server)