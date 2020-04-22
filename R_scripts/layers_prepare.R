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

###### M bam Area ## Verificar a limpeza dos dados q caem em NA

bam_sabiapimenta <- af_extention <= 800.00
plot(bam_sabiapimenta)

values(bam_sabiapimenta)[values(bam_sabiapimenta) == 0] = NA
plot(bam_sabiapimenta)

writeRaster(bam_sabiapimenta, "./data/layers/cropped_layers/BAMM_sabiapimenta.tif")


####### Pseudoabsence # testar

pseudoabsence_area <- (af_extention > 830.000) & (af_extention < 900.00)
plot(pseudoabsence_area)

values(pseudoabsence_area)[values(pseudoabsence_area) == 0] = NA
plot(pseudoabsence_area)

writeRaster(pseudoabsence_area, "./data/layers/cropped_layers/pseudoabsence_area.tif")

