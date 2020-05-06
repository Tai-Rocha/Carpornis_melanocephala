#################################
## Study Bioclim Model 
## Author: Tainá Rocha
## Date: 06 MAy 2020
#################################

##Library
library(raster)
library(rgdal)
#####

Bioclim_Raw <- raster("./results/Carpornis_melanocephala/present/final_models/Carpornis_melanocephala_bioclim_raw_mean.tif")
plot(Bioclim_Raw)
