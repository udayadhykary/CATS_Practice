library(leaflet)
map <- leaflet() %>% addTiles()

map %>% 
fitBounds(85.30, 27.70, 85.25, 27.75) %>% 
  addMeasure()
