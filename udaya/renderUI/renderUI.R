library(shiny)

ui <- fluidPage(
  
  titlePanel("Practicing RenderUI in R Shiny"),
  sidebarLayout(
    sidebarPanel(
      
      selectInput(inputId = "data", "Select the dataset you want to plot", choices = c("iris", "mtcars", "trees")),
      br(),
      uiOutput("vx"),
      br(),
      uiOutput("vy")
    ),
    mainPanel(
      plotOutput("plot")
    )
    
  )
)


server <- function(input, output){
  
  var <- reactive ({
    switch(input$data, 
           "iris" = names(iris),
           "mtcars" = names(mtcars),
           "trees" = names(trees))
  })
  
  
  output$vx <- renderUI({
    selectInput("varx", "Select the X-variable", choices = var())
  })
  
  output$vy <- renderUI({
    selectInput("vary", "Select the Y-variable", choices = var())
  })
  
  output$plot <- renderPlot({
    
    attach(get(input$data))
    plot(x = get(input$varx), y = get(input$vary), xlab = input$varx, ylab = input$vary)
  })
}

shinyApp(ui =ui, server = server)