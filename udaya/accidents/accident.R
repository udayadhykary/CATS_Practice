library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)

setwd("C:\\Users\\udaya\\OneDrive\\Desktop\\accident")
accidents <- read_csv("new_accidents.csv")

arrange(accidents, Start_Time)


accidents <- select(accidents, -Source, -Description, -Street, -Country, -Timezone, 
                       -Weather_Timestamp, -Airport_Code, -Bump, -Sunrise_Sunset, -Civil_Twilight, 
                       -Nautical_Twilight, -Astronomical_Twilight, -Start_Lat, -Start_Lng, -End_Lat, -End_Lng, -`Wind_Chill(F)`)


accidents$Date <- format(as.Date(accidents$`Start_Time`,"%Y-%m-%d"), format = "%d/%m/%Y")
accidents$Year <- format(as.Date(accidents$`Start_Time`,"%Y-%m-%d"), format = "%Y")

accidents <- accidents %>% relocate(Date, .after = Severity)
accidents <- accidents %>% relocate(Year, .after = Date)


accidents$S_Time <- format(accidents$Start_Time,"%H:%M")
accidents$E_Time <- format(accidents$End_Time,"%H:%M")

accidents <- accidents %>% mutate(Duration = End_Time - Start_Time)
accidents <- accidents %>% tidyr::separate(Duration, c("Duration_Minutes"),extra='drop')
accidents %>% transmute(S_Time, Start_Time, E_Time, End_Time, Duration_Minutes)
accidents <- accidents %>% mutate ( Duration_Hours = as.numeric(Duration_Minutes) / 60 )
accidents %>% transmute(S_Time, Start_Time, E_Time, End_Time, Duration_Hours)


months <- as.numeric(format(as.Date(accidents$Date, '%d/%m/%Y'), '%m'))
indx <- setNames( rep(c('winter', 'spring', 'summer',
                        'fall'),each=3), c(12,1:11))
accidents$Season <- unname(indx[as.character(months)])

accidents1 <- accidents %>% drop_na()
View(accidents1)


accidents1$Weather_Condition = as.factor(accidents1$Weather_Condition)
accidents1$Date <- as.Date(accidents1$Date, "%d/%m/%Y")
accidents1$County <- as.factor(accidents1$County)


accidents_CA <- filter(accidents1, State == "CA")
View(accidents_CA)

CAcounties <- accidents_CA %>%group_by(County)
View(CAcounties)
CA_counties <- accidents_CA %>% group_by(County) %>% summarise(CAcounties,Accident_Count = n())


most_freq_weather_CA <- table(accidents_CA$Weather_Condition, useNA = "ifany")%>%
  sort( decreasing = TRUE)%>%
  head(15)
plot(most_freq_weather_CA)


accidents_CA <- filter(accidents_CA, Weather_Condition == "Fair" |
                            Weather_Condition == "Cloudy" |
                            Weather_Condition == "Partly Cloudy" |
                            Weather_Condition == "Mostly Cloudy" |
                            Weather_Condition == "Light Rain" |
                            Weather_Condition == "Overcast" |
                            Weather_Condition == "Haze" |
                            Weather_Condition == "Rain" |
                            Weather_Condition == "Fog" |
                            Weather_Condition == "Heavy Rain" |
                            Weather_Condition == "Fair / Windy" |
                            Weather_Condition == "Smoke" |
                            Weather_Condition == "Clear" |
                            Weather_Condition == "Scattered Clouds" |
                            Weather_Condition == "Partly Cloudy / Windy")

CA_group <- accidents_CA %>% group_by(County,Date, S_Time)

overall_accidents_info_CA <- summarise(CA_group,
                                       Accident_Count = n(),
                                       Visibility_Mean = mean(`Visibility(mi)`),
                                       Temperature_Mean = mean(`Temperature(F)`),
                                       Humidity_Mean = mean(`Humidity(%)`),
                                       Pressure_Mean = mean(`Pressure(in)`),
                                       Wind_Speed_Mean = mean(`Wind_Speed(mph)`),
                                       Precipitation = mean(`Precipitation(in)`))
View(overall_accidents_info_CA)
