###############################################################
## Post-processing analysis for Microtus californicus ENMs 
## Author: Tainá Rocha
## DAte: 29 May 2020
###############################################################

### Library pckgs

library(raster)
library(rgdal)

########## Present 
setwd("Vole_raw_mean_Present/")

for(j in 1:length(sub)) {
 
  h <- list.files(path=sub[j], recursive=TRUE, full.names=TRUE,  pattern='.tif')
  print(h)
  
  stack_present <- stack(h)
  print(stack_present)
  
  binary_0.2 <- stack_present >=0.20
  
  b <- paste0(names(binary_0.2@data),"_bin.tif")
  
  writeRaster(binary_0.2, filename=b, bylayer=TRUE, overwrite=TRUE)
  
  continu <-  stack_present * binary_0.2
  
  c <- paste0(names(binary_0.2@data),"_cont.tif")
  
  writeRaster(continu, filename=c, bylayer=TRUE, overwrite=TRUE)
  
  
} 


##########  End



# Crie uma pasta para os novos resultados pos processados

############ DAqui pra baixo não funciona

#continu <-  stack_present * binary_0.2

#c <- paste0(names(binary_0.2@data@names),"_cont.tif")


#c <- paste0(names(binary_0.2@data),"_cont.tif")
#layer_names_cont <- names(binary_0.2)
#layer_names_cont
#names(continu) <- layer_names_cont


#writeRaster(continu, filename=c, bylayer=TRUE, overwrite=TRUE)


