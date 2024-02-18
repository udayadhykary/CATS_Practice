library(shiny)
library(rhandsontable)
ui <- fluidPage(
  
  fluidRow(
    titlePanel(title = "Practicing rhandsontable on R Shiny "),
    hr(),
    column(6,helpText("Non-editable Table"), tableOutput("table1")),
    column(6,helpText("Editable Table"), rHandsontableOutput("table"),
           br(),
           actionButton("save","Save"))
  )
)

a = sample(1:20, replace = TRUE)
b = sample(21:40, replace = TRUE)
c = a+b
d = b-a
df1 = data.frame(a=a, b=b, c=c, d=d)

server <- function(input,output,session){
  
  output$table1 <- renderTable({
    df1
  })
  
  output$table <- renderRHandsontable({ 
    rhandsontable(df1)
    })
  
  observeEvent(input$save, write.csv(hot_to_r(input$table), file = "MyData.csv", row.names = FALSE))
}

shinyApp(ui =ui, server = server)