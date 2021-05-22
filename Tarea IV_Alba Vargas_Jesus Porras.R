## Tarea 4
##Alba y Jesus

rm(list=ls())

library("DBI")
library("odbc")
library("dbplyr")

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

##Primeramente se realiza una visualización
##Preliminar del comportamiento de las variables entre si

plot(drugs[,1:7])

##Podemos observar una relación aparente entre las
##variables marihuana.use vs hallucigenon.use

##Seleccionamos unicamente estas variables

library(dbplyr)
library(tidyverse)
drugs <-data.frame(drugs)
drugs <- select(drugs,marihuana_use,hallucigenon_use)


##Visualizamos el comportamiento de las dos variables
plot(drugs)


##Agregamos una linea de tendencia para obtener una
##mejor visualización

ggplot(drugs, aes(y = marihuana_use, x = hallucigenon_use)) + 
  geom_point() +
  geom_smooth(method = "lm") +
  ggtitle("Marihuana use vs Hallucigenon use")

##Apartir del set de datos realizamos una regresion lineal

regresion_drugs = lm(marihuana_use~hallucigenon_use, data = drugs)

##Generamos una muestra de 50 valores con valores de
##hallucigenon_use entre 2,0 y 8,0

muestra_hallucigenon = data.frame(hallucigenon_use = c(sample(20:80,50,replace = TRUE))/10)
prediccion_drugs = predict(regresion_drugs,muestra_hallucigenon)
resultado = data.frame(muestra_hallucigenon,prediccion_drugs)
View(resultado)

##Regresion sobre el set de datos ideal
plot(drugs$hallucigenon_use,drugs$marihuana_use, xlab='hallucigenon', ylab='marihuana', xlim = c(0,10), ylim = c(0,40))
abline(regresion_drugs)

