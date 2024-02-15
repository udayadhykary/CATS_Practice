library(shiny)
ui <- fluidPage(
        titlePanel("Practicing download plot in R Shiny"),
        sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "x", label = "Select the X-variable", choices = c("Sepal.Length" = 1, "Sepal.Width" = 2, "Petal.Length" =3, "Petal.Width" =4)),
          selectInput(inputId = "y", label = "Select the Y-variable", choices = c("Sepal.Length" = 1, "Sepal.Width" = 2, "Petal.Length" =3, "Petal.Width" =4)),
          radioButtons(inputId = "type", label = "Select the file type", choices = list("png", "pdf")),
          ),
        mainPanel(
          
          plotOutput("plot"), 
          downloadButton(outputId = "down",label = "Download")
        )
      )
)



server <- function(input, output){

x1 <- reactive({
  iris[, as.numeric(input$x)]
  
})


y1 <- reactive({
  iris[, as.numeric(input$y)]
  
})

  
  output$plot <- renderPlot({
    
    plot(x1(),y1())
    
  })
  
  
  output$down <- downloadHandler(
    
    filename = function(){
      paste("iris", input$type, sep = ".")
    },
    
    content = function(file){
      
      if(input$type == "png")
        png(file)
      else
        pdf(file)
      plot(x1(),y1())
      dev.off()
      
    }
  )
}

shinyApp(ui = ui, server = server)