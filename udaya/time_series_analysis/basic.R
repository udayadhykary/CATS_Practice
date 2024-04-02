#learning time series analsis with r studio
library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(forecast)
library(datasets)

data("AirPassengers")

View(head(AirPassengers))


str(AirPassengers)

plot(AirPassengers)


#decomposing the time series data into trend, seasonal and random

decomposed <- decompose(AirPassengers)

plot(decomposed)


#trying to forecast future data

forecast_data <- forecast(AirPassengers, h = 24)

plot(forecast_data)
