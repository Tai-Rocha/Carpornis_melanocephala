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

### Read and load Bioclim Raw Models 

Bioclim <- raster("./results_pre_analysis/Testes_PseudoAbsence/results_bioclim_PA_331_6Variables/Carpornis_melanocephala/present/final_models/Carpornis_melanocephala_bioclim_raw_mean.tif")

plot(Bioclim)

### Defining BAM M Area i.e Area <= 800.000 altitude

PA_AREA <- Bioclim<=0.0028
PA_AREA[PA_AREA == 0] <- NA
plot(PA_AREA)

PA_MASKED <- mask(Bioclim, mask = PA_AREA)
plot(PA_MASKED)

writeRaster(PA_MASKED, "./data/layers/cropped_layers/Final_PA_bamMsabiaPimenta.tif")

### Convert  PA raster to shape 
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

PA_MASKED_SAHPE <- gdal_polygonizeR(PA_MASKED)

writeOGR(PA_MASKED_SAHPE, dsn="./data/shapes/","PA_sabiapimenta_shape", driver="ESRI Shapefile", overwrite_layer=TRUE)   
