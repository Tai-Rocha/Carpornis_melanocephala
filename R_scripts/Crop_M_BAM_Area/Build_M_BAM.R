#############################################################
## Prepare M bam Area from altitude layer
## Author: Tainá Rocha
## Date: 21 April 2020
## Laste update: 22 April 2020
#############################################################

### Library pcgks

library(raster)
library(rgdal)
library(maptools)

### Read and load Atlantic Forest Shape and altitude raster

af_shape <- readOGR("./data/shapes/mata_atlantica11428.shp")
plot(af_shape)

altitude_brasil <- raster("./data/layers/raw_layers/altitude_inpe_br.asc")
plot(altitude_brasil)

### Mask Crop for atlantic forest
af_masked <- mask(x = altitude_brasil, mask = af_shape)
plot(af_masked)

af_extention <- crop(x = af_masked, y = extent(af_shape))
plot(af_extention)

#writeRaster(af_extention, "./data/layers/cropped_layers/af_cropped_alt.tif")

### Defining BAM M Area i.e Area <= 800.000 altitude

bamMtif <- af_extention<1228
bamMtif[bamMtif == 0] <- NA
plot(bamMtif)

BAM_M_MASKED <- mask(af_extention, mask = bamMtif)
plot(BAM_M_MASKED)

writeRaster(BAM_M_MASKED, "./data/layers/cropped_layers/Final_bamMsabiaPimenta.tif")

### Convert M BAM raster to shape 
### Set function (beacuse raster function to do this take a long time (more than 7 hours)!!! Here take 1 minute or less)

gdal_polygonizeR <- function(x, outshape=NULL, gdalformat = 'ESRI Shapefile', 
                             pypath=NULL, readpoly=TRUE, quiet=TRUE) {
  if (isTRUE(readpoly)) require(rgdal)
  if (is.null(pypath)) {
    pypath <- Sys.which('gdal_polygonize.py')
  }
  if (!file.exists(pypath)) stop("Can't find gdal_polygonize.py on your system.") 
  owd <- getwd()
  on.exit(setwd(owd))
  setwd(dirname(pypath))
  if (!is.null(outshape)) {
    outshape <- sub('\\.shp$', '', outshape)
    f.exists <- file.exists(paste(outshape, c('shp', 'shx', 'dbf'), sep='.'))
    if (any(f.exists)) 
      stop(sprintf('File already exists: %s', 
                   toString(paste(outshape, c('shp', 'shx', 'dbf'), 
                                  sep='.')[f.exists])), call.=FALSE)
  } else outshape <- tempfile()
  if (is(x, 'Raster')) {
    require(raster)
    writeRaster(x, {f <- tempfile(fileext='.asc')})
    rastpath <- normalizePath(f)
  } else if (is.character(x)) {
    rastpath <- normalizePath(x)
  } else stop('x must be a file path (character string), or a Raster object.')
  system2('python', args=(sprintf('"%1$s" "%2$s" -f "%3$s" "%4$s.shp"', 
                                  pypath, rastpath, gdalformat, outshape)))
  if (isTRUE(readpoly)) {
    shp <- readOGR(dirname(outshape), layer = basename(outshape), verbose=!quiet)
    return(shp) 
  }
  return(NULL)
}

bamM_sabiaPimenta_Shape <- gdal_polygonizeR(BAM_M_MASKED)

writeOGR(bamM_sabiaPimenta_Shape, dsn="./data/layers/cropped_layers/","bamM_sabiapimenta_shape", driver="ESRI Shapefile", overwrite_layer=TRUE)   
