#############################################################
## Cleaning georreferenced data for Carpornis melanocephala
## Author: Tainá Rocha
## Date: 21 April 2020
## Laste update: 
############################################################

## Library pcgks

library(modleR)
library(raster)
library(rgdal)

## Read and load georreferenced data

sabiapimenta_records <- read.csv("./data/c_melanocephala.csv", sep = ",", dec = ".")


### Bioclimatic variables from worldclim List and stack rescpectively

predictor_sabiapimenta <- list.files(path = './data/layers/current/',
                        pattern = 'tif',
                        full.names = T)

predictors <- stack(predictor_sabiapimenta)

plot(predictors)


## Read and load the pseudoabsence shapefile where pseudoabsence will be generated 

sabiapimenta_pa_area <- readOGR("./data/shapes/PabsenceArea_shape_sabiaPimenta.shp")
plot(sabiapimenta_pa_area)

###
sdmdata_sabiapimenta <- setup_sdmdata(species_name= unique(sabiapimenta_records$sp),
                             occurrences = sabiapimenta_records[,-1],
                             lon = "lon",
                             lat = "lat",
                             predictors = predictors,
                             models_dir = "./results",
                             partition_type = "crossvalidation",
                             cv_partitions = 5,
                             cv_n = 10,
                             seed = 512,
                             buffer_type = "user",
                             buffer_shape = sabiapimenta_pa_area,
                             png_sdmdata = TRUE,
                             n_back = 1000,
                             clean_dupl = TRUE,
                             clean_uni = TRUE,
                             clean_nas = TRUE)

###### Do any

sabia_pimenta_bioclim <- do_any(species_name = unique(sabiapimenta_records$sp),
          algorithm = "bioclim",
          predictors = predictors,
          models_dir = "./results",
          png_partitions = TRUE,
          write_bin_cut = FALSE,
          equalize = TRUE)

###### Final Model - 

final_model(species_name = unique(sabiapimenta_records$sp),
            algorithms = NULL, #if null it will take all the algorithms in disk
            models_dir = "./results",
            which_models = c("raw_mean",
                             "bin_mean",
                             "bin_consensus"),
            consensus_level = 0.5,
            uncertainty = TRUE,
            overwrite = TRUE)