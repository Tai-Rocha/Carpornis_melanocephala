#########################
## Estudando os pontos
## Authos: Tainá Rocha
## Date : 05 May 2020
########################
## Library

library (raster)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(ggrepel)
library(ggsn)
library(rgdal)

## Read data
points <- read.csv("./data/c_melanocephala_nova.csv", sep = ",", dec = ".")

# remover registros duplicados
dups.all <- duplicated(points[, c('lat', 'long')])
pontos <- points[!dups.all, ]

write.csv(pontos, "./data/c_melanocephala_novo_no_duplicates.csv")

# verificar o conjunto de pontos somados 
summary(pontos)

#### Plotar os pontos em um mapa

area <-map_data("world", region="Brazil", zoom=5) 

g <- ggplot() + geom_polygon(data = area,
                             aes(x=long, y = lat, group = group),
                             fill = "lightgrey", color = "lightgrey") + #Note que voce pode mudar as cores do fundo e da borda
  coord_fixed(1.1) + #Use isto para o mapa ficar proporcional
  geom_point(data = pontos, aes(x = long, y = lat), 
             color = "purple", #Escolha a cor dos pontos
             size = 0.5, #Tamanho dos pontos
             alpha = 0.6) + #Transparencia: quanto mais proximo de 1, menos transparente
  
  #geom_text_repel(data=pontos, aes(x=long, y=lat, label=ponto))+ #Use isto para os rotulos dos pontos nao ficarem sobrepostos
  
  theme_bw() +
  ggtitle("Carpornis melanochephala") + #De nome ao plot, caso seja necessario
  labs(x="Longitude", y = "Latitude") + #De nome aos eixos
  
  theme(text = element_text(size=14), #Ajuste os tamanhos das fontes 
        plot.title = element_text(size=14, hjust=0.5),
        axis.text.x = element_text(size = 10, angle=0, hjust=1),
        axis.text.y = element_text(size = 10, angle=0, vjust=1),
        axis.title.x = element_text(size = 12, angle=0),
        axis.title.y = element_text(size = 12, angle=90))

#Vizualize o mapa básico
plot(g)


##### Read altitude Atlatic Forest cropped raster (Bio20)

altitude <- raster("./data/layers/cropped_layers/af_cropped_alt.tif")
plot(altitude)

##### Extract values from point (require a file in format long lat respectively to use extract funtion)

### Inverse
long_lat <- rev(pontos[nrow(pontos):1,])

# Extract values from point
alt_values_coord <- extract(altitude, long_lat[,-3], method='simple', df=T)

alt_values_coord[complete.cases(alt_values_coord), ]

summary(alt_values_coord)

## Write a table

altitude_values <-write.csv(alt_values_coord, "./data/alt_in_coord.csv")

boxplot(alt_values_coord[,2], col="light blue", main="Altitude")


###### Altitude Brasil 

altitude_brasil <- raster("./data/layers/raw_layers/altitude_inpe_br.asc")
plot(altitude_brasil)

# Extract values from point
altbr_values_coord <- extract(altitude_brasil, long_lat, method='simple', df=T)

write.csv(altbr_values_coord, "./data/altbrasil_in_coord.csv")

boxplot(altbr_values_coord[,2], col="light blue", main="Altitude")


### Bio4 

Bio4 <- raster("./data/layers/current/bio4.tif")
plot(Bio4)

bio4_vlaues <- extract(Bio4, long_lat, method="simple", df=T)
boxplot(bio4_vlaues[,2], col="light blue", main="Bio4")

### Bio12 
Bio12 <- raster("./data/layers/current/bio12.tif")
plot(Bio12)

bio12_vlaues <- extract(Bio12, long_lat, method="simple", df=T)
boxplot(bio12_vlaues[,2], col="light blue", main="Bio12")

### Bio15 
Bio15 <- raster("./data/layers/current/bio15.tif")
plot(Bio15)

bio15_vlaues <- extract(Bio15, long_lat, method="simple", df=T)
boxplot(bio15_vlaues[,2], col="light blue", main="Bio15")


