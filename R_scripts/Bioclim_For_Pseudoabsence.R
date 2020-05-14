###############################################################
## Cleaning georreferenced data for Carpornis melanocephala and 
## Buid Bioclim Model For selec pseudoabsence
## Author: Tainá Rocha
## Date: 21 April 2020
## Laste update: 
##############################################################

## Library pcgks

library(modleR)
library(raster)

## Read and load georreferenced data

sabiapimenta_records <- read.csv("./data/c_melanocephala_nova.csv", sep = ",", dec = ".")


### Bioclimatic variables from worldclim List and stack rescpectively

predictor_sabiapimenta <- list.files(path = './data/layers/current/',
                                     pattern = 'tif',
                                     full.names = T)

predictors <- stack(predictor_sabiapimenta)

plot(predictors)


###

sdmdata_sabiapimenta <- setup_sdmdata(species_name= unique(sabiapimenta_records$sp),
                             occurrences = sabiapimenta_records[,-1],
                             lon = "long",
                             lat = "lat",
                             predictors = predictors,
                             models_dir = "./results_bioclim_PA",
                             partition_type = "crossvalidation",
                             cv_partitions = 5,
                             cv_n = 10,
                             seed = 512,
                             png_sdmdata = TRUE,
                             clean_dupl = TRUE,
                             clean_uni = TRUE,
                             clean_nas = TRUE)

###### Do any

sabia_pimenta_bioclim <- do_any(species_name = unique(sabiapimenta_records$sp),
                                predictors = predictors,
                                models_dir = "./results_bioclim_PA",
                                algorithm = c("bioclim"),
                                dismo_threshold = "sensitivity",
                                project_model = FALSE,
                                write_bin_cut = FALSE,
                                sensitivity = 0.9,
                                proc_threshold =  0.5)

###### Final Model - 

final_model_sabia_pimenta <- final_model(species_name = unique(sabiapimenta_records$sp),
            algorithms = NULL, #if null it will take all the algorithms in disk
            models_dir = "./results_bioclim_PA",
            which_models = c("raw_mean",
                             "bin_mean",
                             "bin_consensus"),
            consensus_level = 0.5,
            uncertainty = TRUE,
            overwrite = TRUE)