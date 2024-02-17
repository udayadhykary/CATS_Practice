library(shiny)
options(shiny.maxRequestSize = 9*1024^2)
ui <- fluidPage(
  titlePanel("Practicing fileInput"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file","Choose the file you want to upload"),
      helpText("The maximum file size you can upload is 9MB"),
      tags$hr(),
      h5(helpText("Select the read.table parameters below")),
      checkboxInput(inputId = "header", label = "Header", value = FALSE),
      checkboxInput(inputId = "stringAsFactors", label = "stringasFactors", value = FALSE),
      br(),
      radioButtons(inputId = "sep", label = "Separator", choices = c(Comma = ",", Semicolon = ";", Tab = "\t", Space = " "), selected = ',')
       ),
  mainPanel(
    uiOutput("out")
  )
)
)
server <- function(input, output){
  
  data <- reactive({
    file1 <- input$file
    if(is.null(file1)){return()}
    read.table(file = file1$datapath, sep = input$sep, header = input$header, stringsAsFactors = input$stringAsFactors)
  })
  
  output$filedf <- renderTable({
    if(is.null(data())){return()}
    input$file
  })
  
  output$sum <- renderTable({
    if(is.null(data())){return()}
    summary(data())
  })
  
  output$table <- renderTable({
    if(is.null(data())){return()}
    data()
  })
  
  output$out <- renderUI({
    if(is.null(data()))
      h5("Powered by", tags$img(src= "OIP.jpg", height =200, width =200))
    else
      tabsetPanel(tabPanel("About file", tableOutput("filedf")), tabPanel("Data",tableOutput("table")), tabPanel("Summary", tableOutput("sum")))
  })
}

shinyApp(ui = ui, server = server)