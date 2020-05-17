########################################################################
## Ecological Niche Model Analysis for Carpornis melanocephala
## Author : Tainá Rocha
## Date: 13 May 2020
########################################################################

### Library
library(modleR)
library(raster)

###

sdmdata_sabiapimenta <- setup_sdmdata(species_name= unique(sp_records$sp),
                                      occurrences = sp_records[,-1],
                                      predictors = predictors,
                                      lon = "long",
                                      lat = "lat",
                                      models_dir = "./results_final_6vars",
                                      buffer_type = "user",
                                      buffer_shape = pa_shape,
                                      select_variables = FALSE,
                                      n_back = 1000,
                                      partition_type = "crossvalidation",
                                      cv_partitions = 5,
                                      cv_n = 10,
                                      seed = 512,
                                      png_sdmdata = TRUE,
                                      clean_dupl = TRUE,
                                      clean_uni = TRUE,
                                      clean_nas = TRUE)
