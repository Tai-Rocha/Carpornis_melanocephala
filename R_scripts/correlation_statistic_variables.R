######################
# Choose Layers 
#Author: Tainá Rocha
#Date: 07 May 2020
#####################

## Library

library(raster)
library(rgeos)
library(rgdal)
library(corrplot)
library(corrgram)

### Load, List, Stack Layers
dados <- list.files(path = "/home/taina/Documentos/Worldclim/Worldclim_Present_AF_version_2.1_&_Altitude_AF_INPE/", pattern = ".tif", full.names=TRUE)
biovars <- stack(dados)
plot(biovars)

##### Pontos aleatórios 
points <- spsample(as(biovars@extent, 'SpatialPolygons'), n=1000, type="random")    
plot(biovars[[1]])
plot(points,add=T)

##### Pontos Planilha Original

pontos_raw <-read.csv("./data/c_melanocephala_nova.csv", sep = ",", dec = ".")

# remover registros duplicados

dups.all <- duplicated(pontos_raw[, c('lat', 'long')])
pontos_raw_unique <- pontos_raw[!dups.all, ]

# Inverse (Extract values from point require a file in format long lat respectively to use extract funtion)

long_lat_raw_unique <- rev(pontos_raw_unique[nrow(pontos_raw_unique):1,])


######################################## 

#### Extrair Valores nos Pontos Aletórios
values <- raster::extract(biovars, points@coords, method='simple', df=T)

values_final <- values[complete.cases(values), ]

#### Extrair Valores nos Pontos Originais

values_in_coord <- extract(biovars, long_lat_raw_unique, method='simple', df=T)

values_incoord_final <- values_in_coord[complete.cases(values_in_coord), ]

### Gerando a tabela com as valores extraídos

write.table(values_final, file="Random_points.csv", quote=FALSE, sep=',', dec=".")

write.table(values_incoord_final, file="spcies_points.csv", quote=FALSE, sep=',', dec=".")


######################################## 

#### Aleatórios calcular a os indices de correlacao e niveis de significancia (data.frame)
corrgram(values_final[,-1], bg='blue', cex=1, pch=21, fig=TRUE, main = "Pearson Correlation", lower.panel=panel.pts, upper.panel=panel.conf)

#### Pontos Raw calcular a os indices de correlacao e niveis de significancia (data.frame)
corrgram(values_incoord_final[,-1], bg='blue', cex=1, pch=21, fig=TRUE, main = "Pearson Correlation", lower.panel=panel.pts, upper.panel=panel.conf)


############################# testar script amanhã a partir daqui !!!!!!!!!!!!!!!!!!!!

# selecionar as variaveis (altitude, bio5, bio6, bio12, bio13, bio15)
biovars_selection <- dropLayer(biovars, c('bio1', 'bio2', 'bio3', 'bio4',  'bio7', 'bio8', 'bio9', 'bio10', 'bio11', 'bio14', 'bio16', 'bio17', 'bio18', 'bio19'))
biovars_selection
plot(biovars_selection)


# Extrair os valores de biovar_selection de cada ponto usado nos pontos aleatórios

values_randompoints_selection <- extract(biovars_selection, points@coords, df=T)

values_rp_final_selection <- values_randompoints_selection[complete.cases(values_randompoints_selection), ]


# Extrair os valores de biovar_selection de cada ponto usado 411 pontos da spceis

values_in_coord_selection <- extract(biovars_selection, long_lat_raw_unique, method='simple', df=T)

values_spcoord_final_selection <- values_in_coord_selection[complete.cases(values_in_coord_selection), ]

# Calcular novamente os indices de correlacao e niveis de significancia (data.frame)

#### Aleatórios calcular a os indices de correlacao e niveis de significancia (data.frame)
corrgram(values_rp_final_selection[,-1], bg='blue', cex=1, pch=21, fig=TRUE, main = "Pearson Correlation 2", lower.panel=panel.pts, upper.panel=panel.conf)

#### Pontos Raw calcular a os indices de correlacao e niveis de significancia (data.frame)
corrgram(values_spcoord_final_selection[,-1], bg='blue', cex=1, pch=21, fig=TRUE, main = "Pearson Correlation 2", lower.panel=panel.pts, upper.panel=panel.conf)

######################################################################################################   

#Performer same test via ggplot

######################################################################################################  





################################### Among All Variables ###############################################

### Random Points. Significance test and visualize correlation points/variables.

random_corrplota <- cor(values_final[,-1])
corrplot(random_corrplota, method="circle", type = 'upper')
View(random_corrplota)

write.table(random_corrplota, file="random_corrplota.csv", quote=FALSE, sep=';', dec=",")

## 

cor.mtest <- function(random_corrplota, conf.level = 0.95) {
  mat <- as.matrix(random_corrplota)
  n <- ncol(random_corrplota)
  p.mat <- lowCI.random_corrplota <- uppCI.random_corrplota <- matrix(NA, n, n)
  diag(p.mat) <- 0
  diag(lowCI.random_corrplota) <- diag(uppCI.random_corrplota) <- 1
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(random_corrplota[, i], random_corrplota[, j], conf.level = conf.level)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
      lowCI.random_corrplota[i, j] <- lowCI.random_corrplota[j, i] <- tmp$conf.int[1]
      uppCI.random_corrplota[i, j] <- uppCI.random_corrplota[j, i] <- tmp$conf.int[2]
    }
  }
  return(list(p.mat, lowCI.random_corrplota, uppCI.random_corrplota))
}

res1 <- cor.mtest(random_corrplota, 0.95)
res2 <- cor.mtest(random_corrplota, 0.99)

corrplot(random_corrplota, p.mat = res1[[1]], sig.level = 0.05)
corrplot(random_corrplota, p.mat = res1[[1]], insig = "p-value")
corrplot(random_corrplota, p.mat = res1[[1]], insig = "p-value", sig.level = -1)



### Species Points. Significance test and visualize correlation points/variables.

sp_points_corrplota <- cor(values_incoord_final[,-1])
corrplot(sp_points_corrplota, method="circle", type = 'upper')
View(sp_points_corrplota)

write.table(sp_points_corrplota, file="sp_points_corrplota.csv", quote=FALSE, sep=';', dec=",")

##

cor.mtest <- function(sp_points_corrplota, conf.level = 0.95) {
  mat <- as.matrix(sp_points_corrplota)
  n <- ncol(sp_points_corrplota)
  p.mat <- lowCI.sp_points_corrplota <- uppCI.sp_points_corrplota <- matrix(NA, n, n)
  diag(p.mat) <- 0
  diag(lowCI.sp_points_corrplota) <- diag(uppCI.sp_points_corrplota) <- 1
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(sp_points_corrplota[, i], sp_points_corrplota[, j], conf.level = conf.level)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
      lowCI.sp_points_corrplota[i, j] <- lowCI.sp_points_corrplota[j, i] <- tmp$conf.int[1]
      uppCI.sp_points_corrplota[i, j] <- uppCI.sp_points_corrplota[j, i] <- tmp$conf.int[2]
    }
  }
  return(list(p.mat, lowCI.sp_points_corrplota, uppCI.sp_points_corrplota))
}

res1 <- cor.mtest(sp_points_corrplota, 0.95)
res2 <- cor.mtest(sp_points_corrplota, 0.99)

corrplot(sp_points_corrplota, p.mat = res1[[1]], sig.level = 0.05)
corrplot(sp_points_corrplota, p.mat = res1[[1]], insig = "p-value")
corrplot(sp_points_corrplota, p.mat = res1[[1]], insig = "p-value", sig.level = -1)


################################### Variables Selected ###############################################

### Random Points. Significance test and visualize correlation points/variables.



corplota_random_final <- cor(values_rp_final_selection[,-1])
corrplot(corplota_random_final, method="circle", type = 'upper')
View(corplota_random_final)

write.table(corplota_random_final, file="cor2_random_corrplota.csv", quote=FALSE, sep=';', dec=",")

##
cor.mtest <- function(corplota_random_final, conf.level = 0.95) {
  mat <- as.matrix(corplota_random_final)
  n <- ncol(corplota_random_final)
  p.mat <- lowCI.corplota_random_final <- uppCI.corplota_random_final <- matrix(NA, n, n)
  diag(p.mat) <- 0
  diag(lowCI.corplota_random_final) <- diag(uppCI.corplota_random_final) <- 1
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(corplota_random_final[, i], corplota_random_final[, j], conf.level = conf.level)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
      lowCI.corplota_random_final[i, j] <- lowCI.corplota_random_final[j, i] <- tmp$conf.int[1]
      uppCI.corplota_random_final[i, j] <- uppCI.corplota_random_final[j, i] <- tmp$conf.int[2]
    }
  }
  return(list(p.mat, lowCI.corplota_random_final, uppCI.corplota_random_final))
}

res1 <- cor.mtest(corplota_random_final, 0.95)
res2 <- cor.mtest(corplota_random_final, 0.99)

corrplot(corplota_random_final, p.mat = res1[[1]], sig.level = 0.05)
corrplot(corplota_random_final, p.mat = res1[[1]], insig = "p-value")
corrplot(corplota_random_final, p.mat = res1[[1]], insig = "p-value", sig.level = -1)



### Species Points. Significance test and visualize correlation points/variables.


final_sppoints_corrplota <- cor(values_spcoord_final_selection[,-1])
corrplot(final_sppoints_corrplota, method="circle", type = 'upper')
View(final_sppoints_corrplota)

write.table(final_sppoints_corrplota, file="final_sp_points_corrplota.csv", quote=FALSE, sep=';', dec=",")

## 
cor.mtest <- function(final_sppoints_corrplota, conf.level = 0.95) {
  mat <- as.matrix(final_sppoints_corrplota)
  n <- ncol(final_sppoints_corrplota)
  p.mat <- lowCI.final_sppoints_corrplota <- uppCI.final_sppoints_corrplota <- matrix(NA, n, n)
  diag(p.mat) <- 0
  diag(lowCI.final_sppoints_corrplota) <- diag(uppCI.final_sppoints_corrplota) <- 1
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(final_sppoints_corrplota[, i], final_sppoints_corrplota[, j], conf.level = conf.level)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
      lowCI.final_sppoints_corrplota[i, j] <- lowCI.final_sppoints_corrplota[j, i] <- tmp$conf.int[1]
      uppCI.final_sppoints_corrplota[i, j] <- uppCI.final_sppoints_corrplota[j, i] <- tmp$conf.int[2]
    }
  }
  return(list(p.mat, lowCI.final_sppoints_corrplota, uppCI.final_sppoints_corrplota))
}

res1 <- cor.mtest(final_sppoints_corrplota, 0.95)
res2 <- cor.mtest(final_sppoints_corrplota, 0.99)

corrplot(final_sppoints_corrplota, p.mat = res1[[1]], sig.level = 0.05)
corrplot(final_sppoints_corrplota, p.mat = res1[[1]], insig = "p-value")
corrplot(final_sppoints_corrplota, p.mat = res1[[1]], insig = "p-value", sig.level = -1)

