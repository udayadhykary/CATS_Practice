library(leaflet)

map <- leaflet() %>% addTiles() %>% setView(10,10,2)

map %>% addGraticule()