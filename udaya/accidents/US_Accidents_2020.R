library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(shiny)
library(shinydashboard)

setwd("C:\\Users\\udaya\\OneDrive\\Desktop\\accident")
accidents <- read_csv("US_Accidents_March23.csv")

accidents <- accidents %>% filter(Start_Time <= '2020-12-31')
accidents <- accidents %>% filter(Start_Time >= '2020-01-01')
write.csv(accidents, "new_accidents.csv", row.names = FALSE)


