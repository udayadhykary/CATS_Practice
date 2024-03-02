library(tidyverse)
library(nycflights13)
library(Lahman)

sum(mpg$drv == "4")
msleep
View(msleep)

#filtering data set
filter(msleep, !is.na(conservation))

#sorting data set
arrange(mpg, cty)

#piping
mpg %>%
  filter(hwy >= 20) %>%
  arrange(desc(cyl))

#selecting columns
select(mpg, manufacturer, model, displ, hwy)

#creating new variables from old
flights_w_speed <- flights %>%
  mutate(air_speed = distance / air_time * 60)
flights_w_speed

View(flights)
View(flights_w_speed)

flights_w_mins_midnight <- flights %>%
  mutate(dep_mins_midnight = (dep_time %/% 100)*60 + (dep_time %% 100),
         arr_mins_midnight = (arr_time %/% 100)*60 + (arr_time %% 100)) %>%
  select(dep_time, dep_mins_midnight, arr_time, arr_mins_midnight)

flights_w_mins_midnight

flights_w_arr_status <- flights %>%
  mutate(arr_status = ifelse(arr_delay <= 0, 
                             "on time", 
                             "late")) %>%
  select(month, day, arr_delay, origin, dest, arr_status)

flights_w_arr_status


#grouped summaries
mpg %>%
  group_by(manufacturer) %>%
  summarize(average_highway_mileage = mean(hwy)) %>%
  arrange(desc(average_highway_mileage))
