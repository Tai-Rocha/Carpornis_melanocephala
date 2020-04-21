#############################################################
## Prepare buffer area for pseudoabsence and M bam Area
## Author: Tainá Rocha
## Date: 21 April 2020
## Laste update: 
#############################################################

##### Library pcgks

library(raster)
library(rgdal)

#### Read Atlantic Forest Shape and altitude raster

af_shape <- readOGR("./data/shape_masc/matlantica.shp")
plot(af_shape)

altitude_brasil <- raster("./data/layers/raw_layers/altitude_inpe_br.asc")
plot(altitude_brasil)

#### Crop for atlantic forest

af_extention <- crop (altitude_brasil, af_shape)
plot(af_extention)

writeRaster(af_extention, "./data/layers/cropped_layers/af_extention.tif")
