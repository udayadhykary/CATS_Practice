library(shiny)
ui <- fluidPage(
titlePanel(h4("Practicing renderPlot() using R Shiny using 'mtcars' data", align="center")),
sidebarLayout(
  sidebarPanel(
    
   selectInput("var",label = "1.Select the variable you want to Plot:", choices = c("mpg" = 1, "cyl" = 2,"disp" = 3,"hp" = 4, "drat" = 5, "wt" = 6, "qsec" = 7), selected = 1),
 
   sliderInput("bin", "2. Select the number of histogram BINs by sliding the slider", min =1, max =5, value =2),
   
   radioButtons("colour", label ="3. Select the colour of histogram", choices = c("Red","Green","Blue","Yellow"), selected = "Blue")
   
   
  ),
  mainPanel(
    textOutput("t1"),
    br(),
    textOutput("t2"),
    br(),
    textOutput("t3"), 
    br(),
    plotOutput("hist")
  )
)
)

data(mtcars)

server<- function(input, output){
  
  output$t1 <- renderText({
    colm = as.numeric(input$var)
    paste("The variable you selected is", names(mtcars[colm]))
  })
  
  output$t2 <- renderText({
    paste("The number of BINs you selected is", input$bin)
  })

  output$t3 <- renderText({
    paste("The colour of histogram is", input$colour)
  })
  
  output$hist <- renderPlot(
    {
      colm = as.numeric(input$var)
      hist(mtcars[,colm], col =input$colour, xlim = c(0, max(mtcars[,colm])), main = "Hisogram of mtcars dataset", breaks =seq(0,max(mtcars[,colm]), l =input$bin+1), xlab = names(mtcars[colm]))
    }
  )

}

shinyApp(ui=ui,server=server)

