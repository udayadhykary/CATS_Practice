
library(shiny) 

ui<- fluidPage(
  
  titlePanel(h4('Practicing using tabSetPanel in R Shiny', align = "center")),
  
  sidebarPanel(
    
    selectInput("var", label = "1. Select the Variable whose histogram you want to plot", 
                choices = c("Sepal.Length" = 1, "Sepal.Width" = 2, "Petal.Length" = 3, "Petal.Width"=4),
                selected = 3), 
    
    
    sliderInput("bin", "2. Select the number of histogram BINs by sliding the slider below:", min=5, max=25, value=15),
    
    radioButtons("colour", label = "3. Select the color of histogram",
                 choices = c("Green", "Red",
                             "Yellow"), selected = "Green")
  ),
  
  mainPanel(
    tabsetPanel(type="tab", 
                tabPanel("Summary",verbatimTextOutput("sum")),
                tabPanel("Structure", verbatimTextOutput("str")),
                tabPanel("Data", tableOutput("data")),
                tabPanel("Plot", plotOutput("myhist"))
                
    )
    
  )
  
)


library(shiny)
data(iris)

  
server <-   function(input, output) {
  
  
  output$sum <- renderPrint({
    summary(iris)
    
  })
  
  output$str <- renderPrint({
    str(iris)
    
  })
  
    
    output$data <- renderTable({
      colm <- as.numeric(input$var)
      iris[colm]
  
      
    })
    
    output$myhist <- renderPlot({
      colm <- as.numeric(input$var)
      hist(iris[,colm], breaks=seq(0, max(iris[,colm]), l=input$bin+1), col=input$colour, main="Histogram of iris dataset", xlab=names(iris[colm]), xlim=c(0,max(iris[,colm])))
      
    })
    
  }
shinyApp(ui=ui, server=server)
