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


sabiapimenra_bamM <-r("")
plot(sabiapimenra_bamM)

############################################## Load Species Points ######################################################## 

pontos_raw <-read.csv("./data/c_melanocephala_nova.csv", sep = ",", dec = ".")

# remover registros duplicados

dups.all <- duplicated(pontos_raw[, c('lat', 'long')])
pontos_raw_unique <- pontos_raw[!dups.all, ]

# Inverse (Extract values from point require a file in format long lat respectively to use extract funtion)

long_lat_raw_unique <- rev(pontos_raw_unique[nrow(pontos_raw_unique):1,])

##################################### Worlclim Load, List, Stack Layers ###################################### 

dados <- list.files(path = "/home/taina/Documentos/Worldclim/Worldclim_Present_AF_version_2.1_&_Altitude_AF_INPE/", pattern = ".tif", full.names=TRUE)
biovars <- stack(dados)
plot(biovars)


######################################## Extrac Values ##################################################################### 

### Extrair Valores nos Pontos Originais

values_in_coord <- extract(biovars, long_lat_raw_unique, method='simple', df=T)

values_incoord_final <- values_in_coord[complete.cases(values_in_coord), ]

### Write Tables

write.table(values_incoord_final, file="Species_points_377.csv", quote=FALSE, sep=',', dec=".")


############################################## Building MAtrices Pearson Correlation ############################################ 

#### Species Points
species_correlation_allVars <-corrgram(values_incoord_final[,-1], bg='blue', cex=2, pch=23, fig=TRUE, main = "Pearson Correlation", lower.panel=panel.pts, upper.panel=panel.conf)


################################################### Select (altitude, bio5, bio6, bio12, bio13, bio15) #################################### 
biovars_selection <- dropLayer(biovars, c('bio1', 'bio2', 'bio3', 'bio4',  'bio7', 'bio8', 'bio9', 'bio10', 'bio11', 'bio14', 'bio16', 'bio17', 'bio18', 'bio19'))
biovars_selection
plot(biovars_selection)


######################################## Extrac Values from selected variables ############################################################ 


# Species Points

values_in_coord_selection <- extract(biovars_selection, long_lat_raw_unique, method='simple', df=T)

values_spcoord_final_selection <- values_in_coord_selection[complete.cases(values_in_coord_selection), ]


### Write Tables

write.table(values_spcoord_final_selection, file="Vars_Selection_Species_Points_377.csv", quote=FALSE, sep=',', dec=".")


####################################### Building MAtrices Pearson Correlation for variables selected ############################### 

#### Species Points
corrgram(values_spcoord_final_selection[,-1], bg='blue', cex=3, pch=21, fig=TRUE, main = "Pearson Correlation 2", lower.panel=panel.pts, upper.panel=panel.conf)


######################################################################################################   

#Performer same test via ggplot

######################################################################################################  


################################### Among All Variables ###############################################


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


### Species Points. Significance test and visualize correlation points/variables.


final_sppoints_corrplota <- cor(values_spcoord_final_selection[,-1])
corrplot(final_sppoints_corrplota, method="circle", type = 'upper')
View(final_sppoints_corrplota)

write.table(final_sppoints_corrplota, file="SP_Vars_Selected_Corrplot.csv", quote=FALSE, sep=';', dec=",")

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


