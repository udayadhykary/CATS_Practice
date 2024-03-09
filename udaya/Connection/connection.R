library(RMySQL)
library(DBI)
library(dply)

connection <- dbConnect(RMySQL::MySQL(),
                        dbname = "college",
                        host = "localhost",
                        port = 3306,
                        user = "root",
                        password = "masharostova1@")


dbListTables(connection)

std <- dbGetQuery(connection, "SELECT * FROM student LIMIT 3")

std

glimpse(std)

dbDisconnect(connection)

