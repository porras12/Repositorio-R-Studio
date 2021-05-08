##Tarea II
##Jesus Porras

rm(list=ls())

##Fuente de datos
financials <- read.table("C:/Users/33559/OneDrive/3. Universidad Hispanoamericana/Módulo 5/Tarea II/financials.csv", 
                             header = TRUE,
                             sep = ",")
groceries <- read.table("C:/Users/33559/OneDrive/3. Universidad Hispanoamericana/Módulo 5/Tarea II/Groceries data.csv", 
                         header = TRUE,
                         sep = ",")
drugs <- read.table("C:/Users/33559/OneDrive/3. Universidad Hispanoamericana/Módulo 5/Tarea II/drug-use-by-age.csv", 
                    header = TRUE,
                    sep = ",")



#-------------------------------------------------------------------

## Cuatro plots por base

##Plot 1
boxplot(financials$Price ~ financials$Sector)
# Boxplot muestra tendencias centrales de los precios similares entre sectores, con algunos puntos atíppicos para el caso de Consumer Discretionary

#Plot 2
library(dplyr)
var_Edad_Crack <- select(drugs, age, crack.use)
var_Edad_cocaine <- select(drugs, age, cocaine.use)
var_Edad_Crack <- rename(var_Edad_Crack, Use = crack.use)
var_Edad_cocaine <- rename(var_Edad_cocaine, Use = cocaine.use)

Nombrar <- function(x) {
  as.character(x)
}

var_Edad_Crack <- mutate(var_Edad_Crack, Uso = Nombrar("Crack"))
var_Edad_cocaine <- mutate(var_Edad_cocaine, Uso = Nombrar("Cocaine"))
Compilado_Crack_Cocaine <- union(var_Edad_Crack, var_Edad_cocaine)

library(ggplot2)
ggplot(Compilado_Crack_Cocaine, aes(x = age, y = Use, group = Uso, color = Uso)) +
  geom_line() + geom_point()

#Plot 3
var_Edad_Alucinojeno <- select(drugs, age,hallucinogen.use)
var_Edad_Meth <- select(drugs, age, meth.use)

var_Edad_Alucinojeno <- rename(var_Edad_Alucinojeno, Frecuencia_de_uso = hallucinogen.use)
var_Edad_Meth <- rename(var_Edad_Meth, Frecuencia_de_uso = meth.use)

var_Edad_Alucinojeno <- mutate(var_Edad_Alucinojeno, Type = Nombrar("Alucinojenos"))
var_Edad_Meth <- mutate(var_Edad_Meth, Type = Nombrar("Metanfetamina"))

Compilado_Meth_Alucinojenos <- union(var_Edad_Alucinojeno, var_Edad_Meth)

ggplot(Compilado_Meth_Alucinojenos, aes(x = Type, y = Frecuencia_de_uso, color = Type)) +
  geom_boxplot()
##Se observa una mayor dispersión de los datos de uso de alucinogenos
##mientras que en meth podemos ver un uso constante entre las edades
##lo anterior se puede apreciar en el siguiente gráfico que incorpora la variable edad


#Plot 4
ggplot(Compilado_Meth_Alucinojenos, aes(x = age, y = Frecuencia_de_uso, group = Type, color = Type)) +
  geom_line()

#-------------------------------------------------------------------

##Matriz de correlación

drug_uses = select(drugs,alcohol.use,marijuana.use,cocaine.use,crack.use,heroin.use,hallucinogen.use,inhalant.use,pain.releiver.use,oxycontin.use,tranquilizer.use,stimulant.use,meth.use,sedative.use)

plot(drug_uses[,1:13])
#La mtriz muestra relaciones entre el uso de dos o más drogas
#Un ejemplo de ello es el uso de marihuana y alucinogenos
plot(drug_uses$marijuana.use,drug_uses$hallucinogen.use)



