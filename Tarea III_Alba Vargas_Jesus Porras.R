#Tarea 3 Elabore una ppt donde exponga que es 
#un Modelo de regresión lineal simple y cómo lo 
#aplicaría en un ejemplo real 
#Qué es ggplot2 y elabore 3 ejemplos

rm(list=ls())

library("DBI")
library("odbc")
library(dbplyr)

drugs <- DBI::dbConnect(odbc::odbc(),
                            Driver = "SQL Server",
                            Server = "dbtedamssql.uh.ac.cr",
                            Database = "ETL",
                            UID = rstudioapi::askForPassword("Database user"),
                            PWD = rstudioapi::askForPassword("Database password"),
                            Port = 1433)
##Pentaho_User
##Pentaho_User2021

drugs<-dbGetQuery(drugs,"SELECT * from drugs")
View(drugs)

plot(drugs$marihuana_use,drugs$hallucigenon_use, xlab = "Marihuana use", ylab = "Hallucigenon use", main = "Marihuana vs Hallucigenon")

regresion <- lm(drugs$hallucigenon_use~drugs$marihuana_use)

##y = mx + b

m = regresion[["coefficients"]][["drugs$marihuana_use"]]

b = regresion[["coefficients"]][["(Intercept)"]]

View(regresion)

x = c(0:35)
y = x*m + b
plot(x,y,type = "l", main = "Regresión lineal", xlab="Marihuana use", ylab="Hallucigenon use")


library("ggplot2")
##Plot1
ggplot(drugs, aes(y = marihuana_use, x = hallucigenon_use)) + 
  geom_point() +
  geom_smooth(method = "lm") +
  ggtitle("Marihuana use vs Hallucigenon use")


-----------------------------------------------------------------------
  
  

  
##Plot2
library("dplyr")
var_Edad_Tranquilizer <- select(drugs, age,tranquilizer_use)
var_Edad_Sedative <- select(drugs, age, sedative_use)
var_Edad_Tranquilizer <- rename(var_Edad_Tranquilizer, Frecuencia_de_uso = tranquilizer_use)
var_Edad_Sedative <- rename(var_Edad_Sedative, Frecuencia_de_uso = sedative_use)
var_Edad_Tranquilizer <- mutate(var_Edad_Tranquilizer, Type = "Tranquilizer")
var_Edad_Sedative <- mutate(var_Edad_Sedative, Type = "Sedative")
Compilado_Sedative_Tranquilizer <- union(var_Edad_Tranquilizer, var_Edad_Sedative)

ggplot(Compilado_Sedative_Tranquilizer, aes(x = age, y = Frecuencia_de_uso, fill = Type)) +
  geom_bar(stat="Identity", position = "dodge") + ggtitle("Comparison Tranquilizers vs Sedative") +
  xlab("User Age") + ylab("Frequency")
  

##Plot3
var_frequencia_uso <- select(drugs, age, heroin_use, heroin_frecuency)
ggplot(var_frequencia_uso, aes(x = heroin_frecuency, y= heroin_use, fill = age)) +
  geom_bar(stat="Identity", position = "dodge") + ggtitle("Heroin frequency vs Use")+ coord_flip() + xlab ("Heroin frequency") +
  ylab("Heroin use")

