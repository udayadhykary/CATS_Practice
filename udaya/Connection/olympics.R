library(RMySQL)
library(DBI)
library(dplyr)

connect <- dbConnect(RMySQL::MySQL(),
                        dbname = "olympics",
                        host = "localhost",
                        port = 3306,
                        user = "root",
                        password = "masharostova1@")


dbListTables(connect)

ath <- dbGetQuery(connect, "SELECT * FROM athlete_events LIMIT 3")

ath

glimpse(std)

# How many olympics games have been held?
total_olympics <- dbGetQuery(connect, "SELECT COUNT(DISTINCT games) AS total_olympic_games FROM athlete_events")
total_olympics

# List down all Olympics games held so far. 
total_olympic_games <- dbGetQuery(connect, "SELECT DISTINCT oly.year,oly.season,oly.city FROM athlete_events oly ORDER by year")
total_olympic_games

dbDisconnect(connection)
