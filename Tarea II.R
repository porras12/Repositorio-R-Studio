##Tarea II
##Jesus Porras

rm(list=ls())


financials <- read.table("C:/Users/33559/OneDrive/3. Universidad Hispanoamericana/Módulo 5/Tarea II/financials.csv", 
                             header = TRUE,
                             sep = ",")

groceries <- read.table("C:/Users/33559/OneDrive/3. Universidad Hispanoamericana/Módulo 5/Tarea II/Groceries data.csv", 
                         header = TRUE,
                         sep = ",")

## Cuatro plots por base

##Boxplot

?boxplot
boxplot(financials$Price ~ financials$Sector)




