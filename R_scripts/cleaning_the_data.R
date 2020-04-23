#############################################################
## Cleaning georreferenced data for Carpornis melanocephala
## Author: Tainá Rocha
## Date: 21 April 2020
## Laste update: 
#############################################################

## Library pcgks

library(modleR)


## Read and load georreferenced data

sabiapimenta_records <- read.csv("./data/c_melanocephala.csv", sep = ",", dec = ".")

## Read and load the pseudoabsence shapefile where pseudoabsence will be generated 

sabiapimenta_pa_area <- readOGR("./data/shapes/PabsenceArea_shape_sabiaPimenta.shp")

### Bioclimatic variables from worldclim List and stack rescpectively

predictor_sabiapimenta <- list.files(path = './data/layers/present',
                        pattern = 'tif',
                        full.names = T)

predictors <- stack(predictor_sabiapimenta)

plot(predictors)


sdmdata_sabiapimenta <- setup_sdmdata(species_name = sabiapimenta_records[1],
                             occurrences = sabiapimenta_records,
                             predictors = predictors,
                             models_dir = results,
                             partition_type = "crossvalidation",
                             cv_partitions = 5,
                             cv_n = 10,
                             seed = 512,
                             buffer_type = "user",
                             buffer_shape = alt_masc,
                             png_sdmdata = TRUE,
                             n_back = 1000,
                             clean_dupl = TRUE,
                             clean_uni = TRUE,
                             clean_nas = TRUE,
                             geo_filt = FALSE,
                             geo_filt_dist = 10,
                             select_variables = TRUE,
                             sample_proportion = 0.5,
                             cutoff = 0.7)