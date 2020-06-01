
########################################################################
## Ecological Niche Model Analysis for Carpornis melanocephala
## Using 4 Variables
## Author : Tainá Rocha
## Date: 13 May 2020
########################################################################

### Library

library(modleR)

###

models_algorithms <- do_many (
                            species_name= unique(sp_records$sp),
                             predictors= predictors,
                             models_dir= "./results_final_4vars",
                             bioclim = TRUE, 
                             domain = TRUE,
                             glm = TRUE,
                             mahal = FALSE, 
                             maxent = TRUE, 
                             maxnet = FALSE, 
                             rf = TRUE,
                             svmk = FALSE, 
                             svme = FALSE, 
                             brt = TRUE,
                             dismo_threshold= c("sensitivity"),
                             proc_threshold= 5,
                             equalize = TRUE,
                             project_model = T,
                             proj_data_folder= "./data/layers/current_4vars",
                             png_partitions= FALSE)
