library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(shiny)
library(shinydashboard)
library(lubridate)
library(dplyr)
library(leaflet)
library(purrr)
library(plyr)
library(maps)


setwd("C:\\Users\\udaya\\OneDrive\\Desktop\\accident")
accidents <- read_csv("new_accidents.csv")
summary(accidents)

table(accidents$Severity)

table(accidents$Weather_Condition)


# Relationship between severity and weather condition
ggplot(accidents, aes(x = Severity, fill = Weather_Condition)) +
  geom_bar(position = "dodge") +
  labs(title = "Severity of Accidents by Weather Condition", x = "Severity", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Trends in accident occurrences over time

accidents$Start_Time <- as.Date(accidents$Start_Time)
accidents_by_date <- accidents %>% 
  group_by(Start_Time) %>% 
  summarise(Count = n())

ggplot(accidents_by_date, aes(x = Start_Time, y = Count)) +
  geom_line() +
  labs(title = "Trends in Accident Occurrences Over Time", x = "Date", y = "Number of Accidents")



# Visualize accidents on a map
map_accidents <- leaflet(accidents) %>%
  addTiles() %>%
  addCircleMarkers(~Start_Lat, ~Start_Lng, radius = 2, color = "red", fill = TRUE)
map_accidents

map("usa", fill = TRUE, col = "white", bg = "lightblue")
points(accidents$Start_Lng, accidents$Start_Lat, pch = 20, cex  = 0.01, col = "red")

plot(accidents$`Temperature(F)`, accidents$`Humidity(%)`, cex = 0.01, xlab = "Temperature (Fahrenheit)", ylab = "Humidity")

plot(accidents$`Temperature(F)`, accidents$`Wind_Chill(F)`, xlab = "Temperature (Fahrenheit)")
abline(0, 1)