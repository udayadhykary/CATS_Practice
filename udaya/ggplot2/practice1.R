library(tidyverse)

View(mpg)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point( ) +
  labs(x = "engine displacement (L)",
       y = "highway fuel efficiency (mpg)",
       color = "type of vehicle")

ggplot(mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
  labs(x = "engine displacement (L)",
       y = "highway fuel efficiency (mpg)",
       color = "type of vehicle")

ggplot(mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) +
  labs(x = "engine displacement (L)",
       y = "highway fuel efficiency (mpg)",
       color = "type of vehicle",
       title = "Fuel Economy as a Function of Engine Size",
       subtitle = "Fuel Efficiency and Engine Size are Inversely Related",
       caption = "Data obtained from fueleconomy.gov")

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(mpg, aes(x = displ, y = hwy)) + geom_smooth()

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy), se = FALSE)

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = class))

homeruns <- readr::read_csv("https://raw.githubusercontent.com/jafox11/MS282/main/homeruns.csv")

View(homeruns)

ggplot(data = homeruns) +
  geom_line(mapping = aes(x = year, y = home_run_total, color = league))

ggplot(data = homeruns, mapping = aes(x = year, y = home_run_total, color = league)) +
  geom_line() +
  geom_point()

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = drv, y = hwy))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = price))

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = price), bins = 50)

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 1500)

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = clarity, fill = cut), position = "dodge")

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))
