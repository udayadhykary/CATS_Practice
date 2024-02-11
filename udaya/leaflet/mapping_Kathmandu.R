library(shiny)
library(leaflet)

ui <- fluidPage(
  leafletOutput("map")
  
)


server <- function(input, output) {
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng =  85.3240, lat = 27.7172, zoom = 15) %>%
      addMarkers(lng =  85.3240, lat = 27.7172, popup ="Kathmandu, Nepal") 
    
  })
}

shinyApp(ui=ui, server=server)