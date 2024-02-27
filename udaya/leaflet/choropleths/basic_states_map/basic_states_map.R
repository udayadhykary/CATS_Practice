library(leaflet)
library(magrittr) 

states <- geojsonio::geojson_read("https://rstudio.github.io/leaflet/json/us-states.geojson", what = "sp")
m<-leaflet(states) %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles("MapBox", options = providerTileOptions(
    id = "mapbox.light",
    accessToken = Sys.getenv('MAPBOX_ACCESS_TOKEN')))

m %>% addPolygons()
