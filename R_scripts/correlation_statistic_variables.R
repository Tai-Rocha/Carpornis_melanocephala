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

##################################### BAM


sabiapimenra_bamM <-raster("./data/layers/cropped_layers/bamMsabiaPimenta.tif")
plot(sabiapimenra_bamM)


############################################## Sample Random Points ############################################ 
points <- spsample(as(sabiapimenra_bamM, 'SpatialPolygons'), n=1000, type="random")
plot(sabiapimenra_bamM[[1]])
plot(points,add=T)

##################################### Worlclim Load, List, Stack Layers ###################################### 

dados <- list.files(path = "/home/taina/Documentos/Worldclim/Worldclim_Present_AF_version_2.1_&_Altitude_AF_INPE/", pattern = ".tif", full.names=TRUE)
biovars <- stack(dados)
plot(biovars)

######################################## Extrac Values ######################################################## 

### Extrair Valores nos Pontos Aletórios

values <- raster::extract(biovars, points@coords, method='simple', df=T)

values_final <- values[complete.cases(values), ]


### Write Tables

write.table(values_final, file="Random_points.csv", quote=FALSE, sep=',', dec=".")

###################################### Building MAtrices Pearson Correlation ################################## 

#### Random Points

random_correlation_allVars <- corrgram(values_final[,-1], bg='blue', cex=2, pch=23, fig=TRUE, main = "Pearson Correlation", lower.panel=panel.pts, upper.panel=panel.conf)


################################################### Select (altitude, bio5, bio6, bio12, bio13, bio15) #################################### 
biovars_selection <- dropLayer(biovars, c('bio1', 'bio2', 'bio3', 'bio4',  'bio7', 'bio8', 'bio9', 'bio10', 'bio11', 'bio14', 'bio16', 'bio17', 'bio18', 'bio19'))
biovars_selection
plot(biovars_selection)


######################################## Extrac Values from selected variables ############################################################ 

# Random Points

values_randompoints_selection <- extract(biovars_selection, points@coords, df=T)

values_rp_final_selection <- values_randompoints_selection[complete.cases(values_randompoints_selection), ]

### Write Tables

write.table(values_rp_final_selection, file="Vars_Selection_Random_Points.csv", quote=FALSE, sep=',', dec=".")



####################################### Building MAtrices Pearson Correlation for variables selected ############################### 

#### Random Points

corrgram(values_rp_final_selection[,-1], bg='blue', cex=3, pch=21, fig=TRUE, main = "Pearson Correlation ", lower.panel=panel.pts, upper.panel=panel.conf)


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


################################### Variables Selected ###############################################

### Random Points. Significance test and visualize correlation points/variables.

corplota_random_final <- cor(values_rp_final_selection[,-1])
corrplot(corplota_random_final, method="circle", type = 'upper')
View(corplota_random_final)

write.table(corplota_random_final, file="Random_Vars_Selected_Corrplot.csv", quote=FALSE, sep=';', dec=",")

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



