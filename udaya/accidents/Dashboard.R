library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(shiny)
library(shinydashboard)
library(maps)
library(mapdata)
library(leaflet)

setwd("C:\\Users\\udaya\\OneDrive\\Desktop\\accident")
accidents <- read_csv("new_accidents.csv")
accidents <- drop_na(accidents)

map <- leaflet()
map <- addTiles(map)
map <- setView(map, lng = mean(accidents$Start_Lng), lat = mean(accidents$Start_Lat), zoom = 5)
map <- addCircleMarkers(map, data = accidents, lng = ~Start_Lng, lat = ~Start_Lat, popup = ~Street,
                        label = paste("Latitude:", accidents$Start_Lat, "Longitude:", accidents$Start_Lng),
                        clusterOptions = markerClusterOptions())

ui <- dashboardPage(title = "US_Accidents", skin = "red",
                    dashboardHeader(title = "Analyzing US Accidents Data", titleWidth = 300),
                    dashboardSidebar(
                      
                      sidebarMenu(id = "sidebarmenu",
                                  
                                  menuItem(text = "Barplot of Severity", tabName = "bar_plot_severity", icon = icon("bar-chart")),
                                  menuItem(text = "Barplot of Timezone", tabName = "bar_plot_timezone", icon = icon("bar-chart")),
                                  menuItem(text = "Histogram of Temperature(F)", tabName = "hist_plot_temp", icon = icon("bars")),
                                  menuItem(text = "Histogram of Wind_Chill(F)", tabName = "hist_plot_wind", icon = icon("bars")),
                                  menuItem(text = "Barplot of Sunrise and Sunset", tabName = "bar_plot_sun", icon = icon("bar-chart")),
                                  menuItem(text = "Top States with Highest Accidents", tabName = "high_accidents", icon = icon("sort-desc")),
                                  menuItem(text = "Histogram of Precipitation(in).", tabName = "hist_plot_prec", icon = icon("bars")),
                                  menuItem(text = "Histogram of Humidity(%)", tabName = "hist_plot_humi", icon = icon("bars")),
                                  menuItem(text = "Histogram of Visibility(mi)", tabName = "hist_plot_visi", icon = icon("bars")),
                                  menuItem(text = "Scatter plot of Different Variables", tabName = "scatter", icon = icon("bar-chart")),
                                  menuItem(text = "Top Weather Condition", tabName = "cond", icon = icon("sort-desc")),
                                  menuItem(text = "Top Cities with Highest Accidents", tabName = "cities", icon = icon("sort-desc")),
                                  menuItem(text = "Accidents on Map", tabName = "map_accidents", icon = icon("map")),
                                  menuItem(text = "Mapping using leaflet package", tabName = "leaf_map", icon = icon("map"))
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
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins1","Enter the no. of bins: ", min = 1, max = 100, value = 50)),
                                  box(title = "Histogram of temperature", status = "primary", plotOutput("plot3"))
                                )
                        ),
                        
                        tabItem(tabName = "hist_plot_wind", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins2","Enter the no. of bins: ", min = 1, max = 100, value = 50)),
                                  box(title = "Histogram of Wind_Chill(F)", status = "primary", plotOutput("plot4"))
                                )
                        ),
                        
                        tabItem(tabName = "bar_plot_sun", 
                                fluidRow(
                                  box(title = "Barplot of Sunrise and Sunset", status = "primary", plotOutput("plot5"))
                                )
                        ),
                        
                        tabItem(tabName = "high_accidents", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins6","Enter the no. of states having highest no of accidents: ", min = 1, max = 49, value = 10)),
                                  box(title = "Plot of top selected status with most accidents in 2020", status = "primary", plotOutput("plot6"))
                                )
                        ),
                        
                        tabItem(tabName = "hist_plot_prec", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins3","Enter the no. of bins: ", min = 1, max = 100, value = 50)),
                                  box(title = "Histogram of Precipitaiton(in).", status = "primary", plotOutput("plot7"))
                                )
                        ),
                        
                        tabItem(tabName = "hist_plot_humi", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins4","Enter the no. of bins: ", min = 1, max = 100, value = 50)),
                                  box(title = "Histogram of Humidity(%)", status = "primary", plotOutput("plot8"))
                                )
                        ),
                        
                        tabItem(tabName = "hist_plot_visi", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins5","Enter the no. of bins: ", min = 1, max = 100, value = 50)),
                                  box(title = "Histogram of Visibility(mi)", status = "primary", plotOutput("plot9"))
                                )
                        ),
                        
                        tabItem(tabName = "scatter", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      selectInput("xvar", "Select the X-variable you want to plot", choices = names(accidents), selected = "Temperature(F)"),
                                      br(),
                                      selectInput("yvar", "Select the Y-variable you want to plot", choices = names(accidents), selected = "Temperature(F)")),
                                  box(title = "Scatter plot of Different Variables", status = "primary", plotOutput("plot10"))
                                )
                        ),
                        
                        tabItem(tabName = "cond", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins7","Enter the no. of conditions you want to see (in desc order): ", min = 1, max = 85, value = 10)),
                                  box(title = "Plot of top selected weather condtion", status = "primary", plotOutput("plot11"))
                                )
                        ),
                        
                        tabItem(tabName = "cities", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins8","Enter the no. of cities with highest no. of accidents: ", min = 1, max = 50, value = 10)),
                                  box(title = "Plot of top selected weather condtion", status = "primary", plotOutput("plot12"))
                                )
                        ),
                        
                        tabItem(tabName = "map_accidents", 
                                fluidRow(
                                  box(title = "Plot of US_Accidents in map", status = "primary", plotOutput("plot13"))
                                )
                        ),
                        
                        tabItem(tabName = "leaf_map",
                                title = "Plot of US_Accidents in map using leaflet package", status = "primary", leafletOutput("plot14")
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
    
    tz<- count(accidents$Timezone)
    rf_timezone <- tz$freq / sum(tz$freq)
    barplot(rf_timezone, names.arg = tz$x, main = "Relative Frequency of Timezone")
    
  })
  
  output$plot3 <- renderPlot({
    
    hist(accidents$`Temperature(F)`, breaks=seq(-90, 210, l= input$bins1+1), xlab = "Temperature (Fahrenheit)", main = "Histogram of Temperature")
    
  })
  
  output$plot4 <- renderPlot({
    
    hist(accidents$`Wind_Chill(F)`, breaks=seq(-90, 190, l= input$bins2+1), xlab = "Wind Chill (Fahrenheit)", main = "Histogram of Wind Chill")
    
  })
  
  output$plot5 <- renderPlot({
    
    ss<- count(accidents$Sunrise_Sunset)
    rf_sunrise_sunset <- ss$freq/sum(ss$freq)
    barplot(rf_sunrise_sunset, names.arg = ss$x, main = "Relative Frequency of sunrise_sunset")
  })
  
  output$plot6 <- renderPlot({
    
    accidents_by_state <- table(accidents$State)
    
    accidents_by_state_df <- as.data.frame(accidents_by_state)
    
    names(accidents_by_state_df) <- c("State", "Accidents")
    
    sorted_by_states<- accidents_by_state_df[order(-accidents_by_state_df$Accidents), ]
    
    top_states <- head(sorted_by_states, input$bins6)
    
    ggplot(top_states, aes(x = reorder(State, -Accidents), y = Accidents)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(x = "State", y = "Number of Accidents", title = paste("Top", input$bins6, "States with Highest Number of Accidents")) +
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
  
  output$plot11 <- renderPlot({
    
    weather_condition <- table(accidents$Weather_Condition)
    
    weather_condition_df <- as.data.frame(weather_condition)
    
    names(weather_condition_df) <- c("Condition", "Count")
    
    sorted_weather_condition <- weather_condition_df[order(-weather_condition_df$Count), ]
    
    top_conditions <- head(sorted_weather_condition, input$bins8)
    
    ggplot(top_conditions, aes(x = reorder(Condition, -Count), y = Count)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(x = "Weather Condition", y = "Count", title = paste("Top",input$bins7, "Weather Conditions during Accidents")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  
  output$plot12 <- renderPlot({
    
    accidents_by_cities <- table(accidents$City)
    
    accidents_by_cities_df <- as.data.frame(accidents_by_cities)
    
    names(accidents_by_cities_df) <- c("City", "Accidents")
    
    sorted_cities <- accidents_by_cities_df[order(-accidents_by_cities_df$Accidents), ]
    
    top_cities <- head(sorted_cities, input$bins8)
    
    ggplot(top_cities, aes(x = reorder(City, -Accidents), y = Accidents)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(x = "City", y = "Number of Accidents", title = paste("Top", input$bins8, "Cities with Highest Number of Accidents")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  
  output$plot13 <- renderPlot({
    
    map("usa", fill = TRUE, col = "white", bg = "lightblue")
    points(accidents$Start_Lng, accidents$Start_Lat, pch = 20, cex  = 0.01, col = "red")
    
  })
  
  output$plot14 <- renderLeaflet({
    
    map
    
  })
  
}

shinyApp(ui = ui, server = server)