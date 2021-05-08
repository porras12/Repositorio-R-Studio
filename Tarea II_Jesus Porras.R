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

boxplot(financials$Price ~ financials$Sector)
# Boxplot muestra tendencias centrales de los precios similares entre sectores, con algunos puntos atíppicos para el caso de Consumer Discretionary

