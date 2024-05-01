library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(shiny)
library(shinydashboard)
library(maps)
library(mapdata)
library(leaflet)

setwd("C:\\Users\\udaya\\OneDrive\\Desktop\\viz")
aadt <- read_csv("aadt.csv")

non_na_rows <- aadt[!is.na(aadt$`AADT by Sub-Corridor`), ]

aadt_corr <- non_na_rows[, c("Corridor Name", "AADT by Whole Corridor")]
aaaadt_corr <- drop_na(aadt_corr)

aadt_sub_corr <- non_na_rows[, c("ON_ROAD", "AADT by Sub-Corridor")]
aadt_sub_corr <- drop_na(aadt_sub_corr)

merged <- read_csv("Merged.csv")
mtti_am <- merged[, c("RoadName", "Mean travel time index (AM)")]
mtti_noon <- merged[, c("RoadName", "Mean travel time index (Noon)")]
mtti_pm <- merged[, c("RoadName", "Mean travel time index (PM)")]

mud_am <- merged[, c("RoadName", "Mean Unit Delay (per vehicle, minutes)(AM)")]
mud_noon <- merged[, c("RoadName", "Mean Unit Delay (per vehicle, minutes)(Noon)")]
mud_pm <- merged[, c("RoadName", "Mean Unit Delay (per vehicle, minutes)(PM)")]

map <- leaflet()
map <- addTiles(map)
map <- setView(map, lng = mean(non_na_rows$LONGITUDE), lat = mean(non_na_rows$LATITUDE), zoom = 5)
map <- addMarkers(map, data = non_na_rows, lng = ~LONGITUDE, lat = ~LATITUDE, popup = ~ON_ROAD,
                        label = paste("Latitude:", non_na_rows$LATITUDE, "Longitude:", non_na_rows$LONGITUDE),
                        clusterOptions = markerClusterOptions())

ui <- dashboardPage(title = "US_Accidents", skin = "blue",
                    dashboardHeader(title = "Listing Roadways with Highest Volume and Congestion", titleWidth = 600),
                    dashboardSidebar(
                      
                      sidebarMenu(id = "sidebarmenu",
                                  
                                  menuItem(text = "Map", tabName = "map_roads", icon = icon("map")),
                                  menuItem(text = "Corridors with highest AADT", tabName = "corr", icon = icon("sort-desc")),
                                  menuItem(text = "Sub-Corridors with highest AADT", tabName = "subcorr", icon = icon("sort-desc")),
                                  menuItem(text = "Mean Travel Time Index by Sub-corridors", tabName = "meantti", icon = icon("sort-desc")),
                                  menuItem(text = "Mean Unit delay by Sub-corridors", tabName = "meanud", icon = icon("sort-desc"))
                      )
                    ),
                    dashboardBody(
                      tabItems(
                        
                        tabItem(tabName = "map_roads",
                                title = "Plot of Roads in map using leaflet package", status = "primary", leafletOutput("plot9")
                        ),
                        
                        tabItem(tabName = "corr", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins1","Enter the no. of Corridors: ", min = 1, max = 68, value = 10), width = 3),
                                  box(title = "Plot of top selected AADT by Corridors", status = "primary", plotOutput("plot1"), width = 9)
                                )
                        ),
                        
                        tabItem(tabName = "subcorr", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins2","Enter the no. of Sub-Corridors: ", min = 1, max = 105, value = 10), width = 3),
                                  box(title = "Plot of top selected AADT by Sub-Corridors", status = "primary", plotOutput("plot2"), width = 9)
                                )
                        ),
                        
                        
                        tabItem(tabName = "meantti", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins3","Enter the no. of roads with highest no of mean travel time index(AM Peak): ", min = 1, max = 106, value = 10), width = 3),
                                  box(title = "Plot of top selected roads with highest mean travel time index(AM Peak)", status = "primary", plotOutput("plot3"), width = 9)
                                ),
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins4","Enter the no. of roads with highest no of mean travel time index(MidDay): ", min = 1, max = 106, value = 10), width = 3),
                                  box(title = "Plot of top selected roads with highest mean travel time index(MidDay)", status = "primary", plotOutput("plot4"), width = 9)
                                ),
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins5","Enter the no. of roads with highest no of mean travel time index(PM Peak): ", min = 1, max = 106, value = 10), width = 3),
                                  box(title = "Plot of top selected roads with highest mean travel time index(PM Peak)", status = "primary", plotOutput("plot5"), width = 9)
                                )
                        ),
                        
                        tabItem(tabName = "meanud", 
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins6","Enter the no. of roads with highest no of mean unit delay(AM Peak): ", min = 1, max = 106, value = 10), width = 3),
                                  box(title = "Plot of top selected roads with highest unit delay(AM Peak)", status = "primary", plotOutput("plot6"), width = 9)
                                ),
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins7","Enter the no. of roads with highest no of mean unit delay(MidDay): ", min = 1, max = 106, value = 10), width = 3),
                                  box(title = "Plot of top selected roads with highest unit delay(MidDay)", status = "primary", plotOutput("plot7"), width = 9)
                                ),
                                fluidRow(
                                  box(title = "Dashboard Controls",status = "warning", solidHeader = T, background = "light-blue",
                                      sliderInput("bins8","Enter the no. of roads with highest no of mean unit delay(PM Peak): ", min = 1, max = 106, value = 10), width = 3),
                                  box(title = "Plot of top selected roads with highest unit delay(PM Peak)", status = "primary", plotOutput("plot8"), width = 9)
                                )
                        )
                      )
                     )
)

server <- function(input, output, session){
  

  
  output$plot1 <- renderPlot({
    
    aadtcorr <- as.data.frame(aadt_corr)
    
    names(aadtcorr) <- c("Corridor Name", "AADT by Whole Corridor")
    
    sorted_by_aadt<- aadtcorr[order(-aadtcorr$`AADT by Whole Corridor`), ]
    
    top_aadt <- head(sorted_by_aadt, input$bins1 )
    
    ggplot(top_aadt, aes(x = reorder(`Corridor Name`, -`AADT by Whole Corridor`), y = `AADT by Whole Corridor`)) +
      geom_bar(stat = "identity", fill = "darkgreen") +
      labs(x = "Corridor Name", y = "AADT by Whole Corridor", title = paste("Top", input$bins1, "Corridors with Highest Number of AADT")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })

  
  output$plot2 <- renderPlot({
    
    aadtsubcorr <- as.data.frame(aadt_sub_corr)
    
    names(aadtsubcorr) <- c("Sub-Corridor Name", "AADT by Sub-Corridor")
    
    sorted_by_sub_aadt<- aadtsubcorr[order(-aadtsubcorr$`AADT by Sub-Corridor`), ]
   
    top_sub_aadt <- head(sorted_by_sub_aadt, input$bins2 )
    
    ggplot(top_sub_aadt, aes(x = reorder(`Sub-Corridor Name`, -`AADT by Sub-Corridor`), y = `AADT by Sub-Corridor`)) +
      geom_bar(stat = "identity", fill = "red") +
      labs(x = "Sub-Corridor Name", y = "AADT by Sub-Corridor", title = paste("Top", input$bins2, "Sub-Corridors with Highest Number of AADT")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  
  output$plot3 <- renderPlot({
    
    sorted_by_mtti_am<- mtti_am[order(-mtti_am$`Mean travel time index (AM)`), ]
    
    top_mtti_am <- head(sorted_by_mtti_am, input$bins3 )
    
    ggplot(top_mtti_am, aes(x = reorder(`RoadName`, -`Mean travel time index (AM)`), y = `Mean travel time index (AM)`)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(x = "Road Name", y = "Mean Travel Time Index in AM Peak", title = paste("Top", input$bins3, "Roads with Highest Mean Travel Time Index in AM Peak")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })

  output$plot4 <- renderPlot({
    
    sorted_by_mtti_noon<- mtti_noon[order(-mtti_noon$`Mean travel time index (Noon)`), ]
    
    top_mtti_noon <- head(sorted_by_mtti_noon, input$bins4 )
    
    ggplot(top_mtti_noon, aes(x = reorder(`RoadName`, -`Mean travel time index (Noon)`), y = `Mean travel time index (Noon)`)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(x = "Road Name", y = "Mean Travel Time Index in MidDay", title = paste("Top", input$bins4, "Roads with Highest Mean Travel Time Index in MidDay")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  
  output$plot5 <- renderPlot({
    
    sorted_by_mtti_pm<- mtti_pm[order(-mtti_pm$`Mean travel time index (PM)`), ]
    
    top_mtti_pm <- head(sorted_by_mtti_pm, input$bins5 )
    
    ggplot(top_mtti_pm, aes(x = reorder(`RoadName`, -`Mean travel time index (PM)`), y = `Mean travel time index (PM)`)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(x = "Road Name", y = "Mean Travel Time Index in PM Peak", title = paste("Top", input$bins5, "Roads with Highest Mean Travel Time Index in PM Peak")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  
  output$plot6 <- renderPlot({
    
    sorted_by_mud_am<- mud_am[order(-mud_am$`Mean Unit Delay (per vehicle, minutes)(AM)`), ]
    
    top_mud_am <- head(sorted_by_mud_am, input$bins6 )
    
    ggplot(top_mud_am, aes(x = reorder(`RoadName`, -`Mean Unit Delay (per vehicle, minutes)(AM)`), y = `Mean Unit Delay (per vehicle, minutes)(AM)`)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(x = "Road Name", y = "Mean Unit Delay (per vehicle, minutes) in AM Peak", title = paste("Top", input$bins6, "Roads with Highest Mean Unit Delay (per vehicle, minutes) in AM Peak")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })

  output$plot7 <- renderPlot({
    
    sorted_by_mud_noon<- mud_noon[order(-mud_noon$`Mean Unit Delay (per vehicle, minutes)(Noon)`), ]
    
    top_mud_noon <- head(sorted_by_mud_noon, input$bins7 )
    
    ggplot(top_mud_noon, aes(x = reorder(`RoadName`, -`Mean Unit Delay (per vehicle, minutes)(Noon)`), y = `Mean Unit Delay (per vehicle, minutes)(Noon)`)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(x = "Road Name", y = "Mean Unit Delay (per vehicle, minutes) in MidDay", title = paste("Top", input$bins6, "Roads with Highest Mean Unit Delay (per vehicle, minutes) in MidDay")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  
  output$plot8 <- renderPlot({
    
    sorted_by_mud_pm<- mud_pm[order(-mud_pm$`Mean Unit Delay (per vehicle, minutes)(PM)`), ]
    
    top_mud_pm <- head(sorted_by_mud_pm, input$bins8 )
    
    ggplot(top_mud_pm, aes(x = reorder(`RoadName`, -`Mean Unit Delay (per vehicle, minutes)(PM)`), y = `Mean Unit Delay (per vehicle, minutes)(PM)`)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(x = "Road Name", y = "Mean Unit Delay (per vehicle, minutes) in PM Peak", title = paste("Top", input$bins6, "Roads with Highest Mean Unit Delay (per vehicle, minutes) in PM Peak")) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  
  output$plot9 <- renderLeaflet({
    
    map
    
  })
  
}

shinyApp(ui = ui, server = server)
