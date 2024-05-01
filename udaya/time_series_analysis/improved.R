library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(forecast)
library(datasets)
library(tseries)

data(AirPassengers)

class(AirPassengers)

start(AirPassengers)

end(AirPassengers)

frequency(AirPassengers)    

summary(AirPassengers)

plot(AirPassengers)

abline(reg=lm(AirPassengers~time(AirPassengers)))

cycle(AirPassengers)

plot(aggregate(AirPassengers,FUN=mean))

boxplot(AirPassengers~cycle(AirPassengers))

plot(log(AirPassengers))
abline(reg=lm(log(AirPassengers)~time(log(AirPassengers))))

plot(diff(log(AirPassengers)))
abline(reg=lm(diff(log(AirPassengers))~time(diff(log(AirPassengers)))))
adf.test(diff(log(AirPassengers)))

acf(log(AirPassengers))

acf(diff(log(AirPassengers)))

pacf(diff(log(AirPassengers)))

fit <- arima(log(AirPassengers), c(0, 1, 1),seasonal = list(order = c(0, 1, 1), period = 12))

pred <- predict(fit, n.ahead = 10*12)

ts.plot(AirPassengers,2.718^pred$pred, log = "y", lty = c(1,3))




m<- auto.arima(log(AirPassengers), trace = TRUE)

acf(m$residuals, main = "COrrelogram")
pacf(m$residuals, main = "Partial Correlogram")

#Ljung-Box test

Box.test(m$residuals, lag = 20, type = "Ljung-Box")


forecasted <- forecast(m, h = 120)
plot(forecasted)
print(forecasted)

