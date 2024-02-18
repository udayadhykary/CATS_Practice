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
      radioButtons(inputId = "sep", label = "Separator", choices = c(Comma = ",", Semicolon = ";", Tab = "\t", Space = " "), selected = ','),
      h6("You can see the image here"),
      tags$img(src = "OIP.jpg", height = 60, width = 60),
      tags$style("body{background-color:linen; color:brown}"),
      tags$style(".container-fluid{font-style: oblique; border-style: solid}"),
      tags$style(".col-sm-8{border-style: solid}"),
      tags$style(".col-sm-4{border-style: solid}")
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
      h6("This video plays first", br(), tags$video(src= "practice.mp4", type= "video/mp4", height ="200px", width ="200px",controls = "controls"))
    else
      tabsetPanel(tabPanel("About file", tableOutput("filedf")), tabPanel("Data",tableOutput("table")), tabPanel("Summary", tableOutput("sum")))
  })
}

shinyApp(ui = ui, server = server)