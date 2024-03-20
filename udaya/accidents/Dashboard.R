library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(shiny)
library(shinydashboard)

setwd("C:\\Users\\udaya\\OneDrive\\Desktop\\accident")
accidents <- read_csv("new_accidents.csv")


ui <- dashboardPage(title = "US_Accidents", skin = "red",
  dashboardHeader(title = "Analyzing US Accidents Data", titleWidth = 300),
  dashboardSidebar(
    
    sidebarMenu(id = "sidebarmenu",
                
                menuItem(text = "Barplot of Severity", tabName = "bar_plot_severity", icon = icon("bar-chart")),
                menuItem(text = "Barplot of Timezone", tabName = "bar_plot_timezone", icon = icon("bar-chart")),
                menuItem(text = "Histogram of Temperature(F)", tabName = "hist_plot_temp", icon = icon("bars")),
                menuItem(text = "Histogram of Wind_Chill(F)", tabName = "hist_plot_wind", icon = icon("bars")),
                menuItem(text = "Barplot of Sunrise and Sunset", tabName = "bar_plot_sun", icon = icon("bar-chart")),
                menuItem(text = "Top 10 States with Highest Accidents", tabName = "high_accidents", icon = icon("sort-desc")),
                menuItem(text = "Histogram of Precipitation(in).", tabName = "hist_plot_prec", icon = icon("bars")),
                menuItem(text = "Histogram of Humidity(%)", tabName = "hist_plot_humi", icon = icon("bars")),
                menuItem(text = "Histogram of Visibility(mi)", tabName = "hist_plot_visi", icon = icon("bars")),
                menuItem(text = "Scatter plot of Different Variables", tabName = "scatter", icon = icon("bar-chart"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "bar_plot_severity", 
              fluidRow(
                box(title = "Barplot of Severity", status = "primary", plotOutput("plot1"))
                )
              ),
      
      tabItem(tabName = "bar_plot_timezone", 
              fluidRow(
                box(title = "Barplot of Timezone", status = "primary", plotOutput("plot2"))
              )
      ),
      
      tabItem(tabName = "hist_plot_temp", 
              fluidRow(
                box(title = "Histogram of temperature", status = "primary", plotOutput("plot3")),
                box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                    sliderInput("bins1","Enter the no. of bins: ", min = 1, max = 100, value = 50))
              )
      ),
      
      tabItem(tabName = "hist_plot_wind", 
              fluidRow(
                box(title = "Histogram of Wind_Chill(F)", status = "primary", plotOutput("plot4")),
                box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                    sliderInput("bins2","Enter the no. of bins: ", min = 1, max = 100, value = 50))
              )
      ),
      
      tabItem(tabName = "bar_plot_sun", 
              fluidRow(
                box(title = "Barplot of Sunrise and Sunset", status = "primary", plotOutput("plot5"))
              )
      ),
      
      tabItem(tabName = "high_accidents", 
              fluidRow(
                box(title = "Plot of top 10 status with most accidents in 2022", status = "primary", plotOutput("plot6"))
              )
      ),
      
      tabItem(tabName = "hist_plot_prec", 
              fluidRow(
                box(title = "Histogram of Precipitaiton(in).", status = "primary", plotOutput("plot7")),
                box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                    sliderInput("bins3","Enter the no. of bins: ", min = 1, max = 100, value = 50))
              )
      ),
      
      tabItem(tabName = "hist_plot_humi", 
              fluidRow(
                box(title = "Histogram of Humidity(%)", status = "primary", plotOutput("plot8")),
                box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                    sliderInput("bins4","Enter the no. of bins: ", min = 1, max = 100, value = 50))
              )
      ),
      
      tabItem(tabName = "hist_plot_visi", 
              fluidRow(
                box(title = "Histogram of Visibility(mi)", status = "primary", plotOutput("plot9")),
                box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                    sliderInput("bins5","Enter the no. of bins: ", min = 1, max = 100, value = 50))
              )
      ),
      
      tabItem(tabName = "scatter", 
              fluidRow(
                box(title = "Scatter plot of Different Variables", status = "primary", plotOutput("plot10")),
                box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                    selectInput("xvar", "Select the X-variable you want to plot", choices = names(accidents), selected = "Temperature(F)"),
                    br(),
                    selectInput("yvar", "Select the Y-variable you want to plot", choices = names(accidents), selected = "Temperature(F)"))
              )
      )
    )
  )
)

server <- function(input, output, session){
  
  output$plot1 <- renderPlot({
    
    accidents$Severity <- as.integer(accidents$Severity)
    count_severity <- c(sum(accidents$Severity==1), 
                        sum(accidents$Severity==2), 
                        sum(accidents$Severity==3), 
                        sum(accidents$Severity==4)
    )
    
    rf <- count_severity/sum(count_severity)
    
    barplot(rf, names.arg = 1:4, main = "Relative Frequencies of Severity")
    
  })
  
  output$plot2 <- renderPlot({
    
    count_timezone <- accidents %>% count(Timezone)
    rf_timezone <- count_timezone$n / sum(count_timezone$n)
    barplot(rf_timezone, names.arg = count_timezone$Timezone, main = "Relative Frequency of Timezone")
    
  })
  
  output$plot3 <- renderPlot({
    
  hist(accidents$`Temperature(F)`, breaks=seq(-90, 210, l= input$bins1+1), xlab = "Temperature (Fahrenheit)", main = "Histogram of Temperature")
  
  })
  
  output$plot4 <- renderPlot({
    
  hist(accidents$`Wind_Chill(F)`, breaks=seq(-90, 190, l= input$bins2+1), xlab = "Wind Chill (Fahrenheit)", main = "Histogram of Wind Chill")
    
  })
  
  output$plot5 <- renderPlot({
    
  count_sunrise_sunset <- accidents %>% count(Sunrise_Sunset)
  rf_sunrise_sunset <- count_sunrise_sunset$n/sum(count_sunrise_sunset$n)
  barplot(rf_sunrise_sunset, names.arg = count_sunrise_sunset$Sunrise_Sunset, main = "Relative Frequency of sunrise_sunset")

  })
  
  output$plot6 <- renderPlot({
    
  accidents_by_state <- table(accidents$State)
  
  accidents_by_state <- as.data.frame(accidents_by_state)
  
  names(accidents_by_state) <- c("State", "Accidents")
  
  accidents_by_state$State <- factor(accidents_by_state$State, 
                                     levels = accidents_by_state$State[order(-accidents_by_state$Accidents)])
  
  
  top_10_states <- head(accidents_by_state, 10)
  
  ggplot(top_10_states, aes(x = State, y = Accidents)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    labs(x = "State", y = "Number of Accidents", title = "Top 10 States with Highest Number of Accidents") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  })
  
  output$plot7 <- renderPlot({
    
    temp1 <- accidents$`Precipitation(in)`
    temp1 = temp1[temp1 < 1]
    hist(temp1, breaks=seq(0,1,l= input$bins3+1), xlab = "Precipitation (in.)", main = "Histogram of Precipitation")
  
  })
  
  output$plot8 <- renderPlot({
    
  hist(accidents$`Humidity(%)`, breaks=seq(0,105,l= input$bins4+1), xlab = "Humidity", main = "Histogram of Humidity")
    
  })
  
  output$plot9 <- renderPlot({
    
  temp4 <- accidents$`Visibility(mi)`
  temp4 = temp4[temp4 < 12]
  hist(temp4, breaks=seq(0,12,l= input$bins5+1), xlab = "Visibility (miles)", main = "Histogram of Visibility")
  
  })
  
  output$plot10 <- renderPlot({
    
    plot(x = accidents[[input$xvar]], y = accidents[[input$yvar]],
         xlab = input$xvar, ylab = input$yvar,
         main = paste("Scatter Plot of", input$xvar, "vs", input$yvar))
    
  })
  
}

summary(accidents)

shinyApp(ui = ui, server = server)