#########################
## Estudando os pontos
## Authos: Tainá Rocha
## Date : June 2020
########################
## Library

library (raster)
library(ggplot2)
library(ggmap)
library(MASS)
library(maps)
library(mapdata)
library(ggrepel)
library(ggsn)
library(rgdal)

## Read data
points_for_models <- read.csv("./data/carpornis_vars_in_coord.csv", sep = ",", dec = ".")

# verificar o conjunto de pontos somados 
summary(points_for_models)

boxplot(points_for_models[3])


##########################

df <- subset(points_for_models, select=c(lon, lat, Variables, bio12, bio13, bio15, bio20, bio5, bio6))  

library(gridExtra)
library(ggplot2)
p <- list()

for (j in colnames(df)[4:9]) {
  p[[j]] <- ggplot(data=df, aes_string(x="Variables",y=j)) + # Specify dataset, input or grouping col name and Y
    geom_boxplot(aes(fill=factor(Variables))) + guides(fill=FALSE) + # Boxplot by which factor + color guide
    theme(axis.title.y = element_text(face="bold", size=14))  # Make the Y-axis labels bigger/bolder
}

do.call(grid.arrange, c(p, ncol=6))
