##Quiz 1
##Jesus Porras

rm(list=ls())

covid_encuesta <- read.table("C:/Users/33559/OneDrive/3. Universidad Hispanoamericana/Módulo 5/Quiz 1/COVID-19 Encuesta a estudiantes.csv", 
                 header = TRUE,
                 sep = ",")
#View(covid_encuesta)


##--------------------------------------------------------------
##Pregunta 1 
#Hist de Age.of.Subject

hist_age_of_subject = hist(covid_encuesta$Age.of.Subject,main="Age of subject",xlab= "Age")
?hist
##La histograma muestra una tendencia central de las edad alrededor de 20 años


##--------------------------------------------------------------
##Pregunta 2
##Seleccione solo los datos donde la Region.of.residence Delhi-NCR y 
##analice por medio de un plot de barras cuales son los 
##Prefered.social.media.platform

library(dplyr)
Delhi_NCR = (filter(select(covid_encuesta,Region.of.residence,Prefered.social.media.platform),Region.of.residence == "Delhi-NCR"))

plot(as.factor(Delhi_NCR$Prefered.social.media.platform))


Delhi_NCR_GroupBy_Prefered = Delhi_NCR%>%group_by(Prefered.social.media.platform)%>%
  summarise(Cantidad=n())

View(Delhi_NCR_GroupBy_Prefered)

barplot(height = Delhi_NCR_GroupBy_Prefered$Cantidad,names.arg = Delhi_NCR_GroupBy_Prefered$Prefered.social.media.platform)



##--------------------------------------------------------------
##Pregunta 3

##Agrupacion solo por rating y region
Region_Rating_Cantidad = covid_encuesta%>%group_by(Region.of.residence,Rating.of.Online.Class.experience)%>%
  summarise(Cantidad=n())

#View(Region_Rating_Cantidad)


library(dplyr)

##Variables apartes con cada region filtrada
RRC_Delhi = filter(Region_Rating_Cantidad,Region.of.residence == "Delhi-NCR")
RRC_Outside = filter(Region_Rating_Cantidad,Region.of.residence == "Outside Delhi-NCR")

##Dateframe de los rating a evaluar
Rating = data.frame(Rating.of.Online.Class.experience=c("Excellent","Good","Average","Poor","Very poor"))

##Merge para seleccionar unicamente los rating a evaluar en las variables aparte de cada region
RRC_Delhi=merge(RRC_Delhi,Rating,by="Rating.of.Online.Class.experience")
RRC_Outside=merge(RRC_Outside,Rating,by="Rating.of.Online.Class.experience")

View(RRC_Delhi)
View(RRC_Outside)


library(ggplot2)

##Ordenar los rating segun contexto y no alfabeticamente
RRC_Delhi$Rating.of.Online.Class.experience = factor(RRC_Delhi$Rating.of.Online.Class.experience, levels=c("Excellent","Good","Average","Poor","Very poor"))
levels(RRC_Delhi$Rating.of.Online.Class.experience)
RRC_Outside$Rating.of.Online.Class.experience = factor(RRC_Outside$Rating.of.Online.Class.experience, levels=c("Excellent","Good","Average","Poor","Very poor"))
levels(RRC_Outside$Rating.of.Online.Class.experience)


##Graficos de barras para visualizar el comportamiento de Rating por Region
ggplot(data=RRC_Delhi, aes(x=Rating.of.Online.Class.experience, y=Cantidad, fill=Region.of.residence)) +
  labs(y = "Cantidad",x= "Rating", fill = "Region") +
  geom_bar(stat="identity", position="stack")

ggplot(data=RRC_Outside, aes(x=Rating.of.Online.Class.experience, y=Cantidad, fill=Region.of.residence)) +
  labs(y = "Cantidad",x= "Rating", fill = "Region") +
  geom_bar(stat="identity", position="stack")


##Se observa que para los dos tipos de regiones el comportamiento es muy similar
##Las mayores tendencias se concentran en Average y en Very Poor
##Ademas Excellent es una de las clases con menor votacion, por lo que indica 
##necesidades de mejora en la experiencia de las clases online



##--------------------------------------------------------------
##Pregunta 4
##Realice al menos una agrupación 

View(covid_encuesta)

Age_by_Region = covid_encuesta%>%group_by(Region.of.residence)%>%
  summarise(Average_Age=round(mean(Age.of.Subject),1))

View(Age_by_Region)


##--------------------------------------------------------------
##Pregunta 5
##Realice al menos una relación de variables (dispersión)


dispersion = select(covid_encuesta,Time.spent.on.Online.Class,Time.spent.on.self.study,Time.spent.on.fitness,Time.spent.on.sleep,Time.spent.on.social.media,Time.spent.on.TV)
View(dispersion)
plot(dispersion[,1:6])

##No se observan correlacionadas pronunciadas

