library(leaflet)
map <- leaflet() %>% setView(0,0,3)

map %>%
  addProviderTiles(providers$Esri.WorldStreetMap) %>%
  addMiniMap()