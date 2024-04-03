library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(forecast)
library(tseries)

setwd("C:\\Users\\udaya\\OneDrive\\Desktop\\accident")

accidents <- read_csv("new_accidents.csv")

accidents$date <- as.Date(accidents$Start_Time)

accidents_by_date <- table(accidents$date)


accidents_by_date <- as.data.frame(accidents_by_date)

names(accidents_by_date) <- c("Date", "Accidents")

accidents_by_date$Date <- as.Date(accidents_by_date$Date)

acc <- ts(accidents_by_date$Accidents, start = min(accidents_by_date$Date), end = max(accidents_by_date$Date), frequency = 1)

plot(acc, main = "Accidents Time Series")

adf.test(acc)

dacc <- diff(acc)

adf.test(dacc)

plot(dacc, main = "Accidents Time Series")

acf(dacc)
pacf(dacc)

model <- auto.arima(acc, trace = TRUE)

summary(model)

forecast_accidents <- forecast(model, h = 20)

plot(forecast_accidents, main = "Accidents Forecast")

print(forecast_accidents)


