library(RMySQL)
library(DBI)
library(dplyr)

connection <- dbConnect(RMySQL::MySQL(),
                        dbname = "college",
                        host = "localhost",
                        port = 3306,
                        user = "root",
                        password = "masharostova1@")


dbListTables(connection)

#running commmand to fetch data from mysql database directly using R

std <- dbGetQuery(connection, "SELECT * FROM student LIMIT 3")

std

glimpse(std)

#Creating tables in MySQL from R

query <- "CREATE TABLE  AGENTS
(	
  AGENT_CODE CHAR(6) NOT NULL PRIMARY KEY, 
  AGENT_NAME VARCHAR(40), 
  WORKING_AREA VARCHAR(35), 
  PHONE_NO CHAR(15), 
  COUNTRY VARCHAR(25) 
);"

results <- dbSendQuery(connection, query)

dbListTables(connection)

dbClearResult(results)

query <- "INSERT INTO AGENTS(AGENT_CODE, AGENT_NAME, WORKING_AREA, PHONE_NO, COUNTRY) VALUES 
  ('A007', 'Ramasundar', 'Bangalore', '077-25814763', ''),
 ('A003', 'Alex ', 'London', '075-12458969', ''),
 ('A008', 'Alford', 'New York', '044-25874365', ''),
 ('A011', 'Ravi Kumar', 'Bangalore', '077-45625874', ''),
 ('A010', 'Santakumar', 'Chennai', '007-22388644', ''),
 ('A012', 'Lucida', 'San Jose', '044-52981425', ''),
 ('A005', 'Anderson', 'Brisban', '045-21447739', ''),
 ('A001', 'Subbarao', 'Bangalore', '077-12346674', ''),
 ('A002', 'Mukesh', 'Mumbai', '029-12358964', ''),
 ('A006', 'McDen', 'London',  '078-22255588', ''),
 ('A004', 'Ivan', 'Torento', '008-22544166', ''),
 ('A009', 'Benjamin', 'Hampshair', '008-22536178', '');"

results <- dbSendQuery(connection , query)

#Checking if it was added correctly
dbReadTable(connection,"AGENTS")

agnt <- dbGetQuery(connection, "SELECT * FROM AGENTS LIMIT 3")

agnt

glimpse(agnt)

dbDisconnect(connection)

