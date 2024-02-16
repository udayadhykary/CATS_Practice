library(shiny)
ui <- fluidPage(
  titlePanel(h4('Practicing to download file using downloadbutton() and downloadHandler()', align="center")),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Dataset", choices = c("iris", "mtcars")),
      br(),
      radioButtons("type", "Format type:",
                   choices = c("Excel (CSV)", "Text (TSV)","Text (Space Separated)", "Doc")),
      br(),
      downloadButton("downloadData", "Download")
      
    ),
    mainPanel(
      
      tableOutput("table")
    )
  )
)


server <- function(input, output) {
  
 
  datasetInput <- reactive({
    switch(input$dataset,
           "iris" = iris,
           "mtcars" = mtcars)
  })
  

  ext <- reactive({
    switch(input$type,
           "Excel (CSV)" = "csv", "Text (Tab Separated)" = "txt","Text (Space Separated)" = "txt", "Doc" = "doc")
    
  })
  

  output$table <- renderTable({
    datasetInput()
    
  })
  

  output$downloadData <- downloadHandler(
    
  
    filename = function() {
      paste(input$dataset, ext(), sep = ".") 
      
    },
    
    content = function(file) {
      sep <- switch(input$type, "Excel (CSV)" = ",", "Text (Tab Separated)" = "\t","Text (Space Separated)" = " ", "Doc" = " ")
      
      write.table(datasetInput(), file, sep = sep,
                  row.names = FALSE)
    }
  )
}

shinyApp(ui=ui,server=server)