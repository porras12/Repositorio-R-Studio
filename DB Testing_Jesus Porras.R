##DB Testing

rm(list=ls())

#install.packages("DBI")
#library("DBI")
#install.packages("odbc")
#library("odbc")

northwind <- DBI::dbConnect(odbc::odbc(),
                      Driver = "SQL Server",
                      Server = "dbtedamssql.uh.ac.cr",
                      Database = "Northwind",
                      UID = rstudioapi::askForPassword("Database user"),
                      PWD = rstudioapi::askForPassword("Database password"),
                      Port = 1433)



etl <- DBI::dbConnect(odbc::odbc(),
                      Driver = "SQL Server",
                      Server = "dbtedamssql.uh.ac.cr",
                      Database = "ETL",
                      UID = rstudioapi::askForPassword("Database user"),
                      PWD = rstudioapi::askForPassword("Database password"),
                      Port = 1433)



#install.packages("dbplyr")
library(dbplyr)

comercio =  data.frame(tbl(con, "Orders Qry"))
plot(as.factor(comercio$Country))




