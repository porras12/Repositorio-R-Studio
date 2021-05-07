con <- DBI::dbConnect(odbc::odbc(),
                      Driver = "SQL Server",
                      Server = "dbtedamssql.uh.ac.cr",
                      Database = "ETL",
                      UID = rstudioapi::askForPassword("Database user"),
                      PWD = rstudioapi::askForPassword("Database password"),
                      Port = 1433)


install.packages("DBI")
library("DBI")
install.packages("odbc")
library("odbc")


