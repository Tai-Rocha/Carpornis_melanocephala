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

af_shape <- readOGR("./data/shape_masc/mata_atlantica11428.shp")
plot(af_shape)

altitude_brasil <- raster("./data/layers/raw_layers/altitude_inpe_br.asc")
plot(altitude_brasil)

#### Mask Crop for atlantic forest
af_masked <- mask(x = altitude_brasil, mask = af_shape)
plot(af_masked)

af_extention <- crop(x = af_masked, y = extent(af_shape))
plot(af_extention)

writeRaster(af_extention, "./data/layers/cropped_layers/af_cropped_alt.tif")
