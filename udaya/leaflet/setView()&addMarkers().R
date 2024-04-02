library(leaflet)
map = leaflet()
map = addTiles(map)
map = setView(map, lng =  85.3240, lat = 27.7172, zoom = 15)
map = addMarkers(map, lng =  85.3240, lat = 27.7172, popup ="Kathmandu, Nepal")
map
