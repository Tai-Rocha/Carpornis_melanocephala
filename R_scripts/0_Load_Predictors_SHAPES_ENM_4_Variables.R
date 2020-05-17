########################################################################
## Ecological Niche Model Analysis for Carpornis melanocephala
## Using 4 Variables
## Author : Tainá Rocha
## Date: 13 May 2020
########################################################################

### Library
library(modleR)
library(raster)
library(rgdal)
library(rgeos)

## Read and load georreferenced data

sp_records <- read.csv("./data/c_melanocephala_nova.csv", sep = ",", dec = ".")


## BAM For Cropp Variables Predictor

bam_sabiapimenta <- raster("./data/layers/BAM_FINAL.tif")
plot(bam_sabiapimenta)

## PA Absence Shape

pa_shape <- readOGR("./data/shapes/PA_SHAPE.shp")
plot(pa_shape)


### Bioclimatic variables from worldclim List and stack rescpectively

dados <- list.files(path = "./data/layers/Worldclim_Present_AF_version_2.1_&_Altitude_AF_INPE/", pattern = ".tif", full.names=TRUE)

biovars <- stack(dados)
plot(biovars)


################## Select Predictors (altitude, bio5, bio6, bio12, bio13, bio15) ########################################## 

biovars_predictors <- dropLayer(biovars, c('bio1', 'bio2', 'bio3', 'bio5', 'bio6',  'bio7', 'bio8', 'bio9', 'bio10', 'bio11', 'bio13', 'bio14', 'bio16', 'bio17', 'bio18', 'bio19'))
biovars_predictors
plot(biovars_predictors)

### Crop Predictors
# Mask Crop for BAM M Sabiá Pimenta
predictors_masked <- mask(x = biovars_predictors, mask = bam_sabiapimenta, na.rm =T, numThreads = 8)
plot(predictors_masked)

predictors<- crop(x = predictors_masked, y = extent(bam_sabiapimenta))
plot(predictors)

summary(predictors)

################## Select Predictors (altitude, bio5, bio6, bio12, bio13, bio15) ####################

proj_vars <- dropLayer(biovars, c('bio1', 'bio2', 'bio3', 'bio5', 'bio6',  'bio7', 'bio8', 'bio9', 'bio10', 'bio11', 'bio13', 'bio14', 'bio16', 'bio17', 'bio18', 'bio19'))
proj_vars
plot(proj_vars)


