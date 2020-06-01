#Present

ensemble_sp <- ensemble_model(species_name= unique(sp_records$sp),
                              occurrences = sp_records[,-1],lon = "long",
                              lat = "lat",
                              models_dir= "./results_final_6vars",
                              final_dir = "final_models",
                              ensemble_dir = "ensemble", 
                              algorithms = NULL,
                              which_ensemble = c("weighted_average"), 
                              which_final = c("raw_mean","bin_mean" ,"bin_consensus","raw_mean_th","raw_mean_cut"),
                              performance_metric = c("TSSmax"), 
                              dismo_threshold = c("sensitivity"),
                              consensus_level = 0.5,
                              png_ensemble = TRUE, 
                              write_occs = TRUE,
                              write_map = TRUE, 
                              scale_models = TRUE,
                              uncertainty = TRUE,
                              overwrite = T)


## Present Projection

ensemble_sp <- ensemble_model(species_name= unique(sp_records$sp),
               occurrences = sp_records[,-1],lon = "long",
               lat = "lat",
               models_dir= "./results_final_6vars",
               final_dir = "final_models",
               ensemble_dir = "ensemble", 
               proj_dir = "current_6vars" ,
               algorithms = NULL,
               which_ensemble = c("weighted_average"), 
               which_final = c("raw_mean","bin_mean" ,"bin_consensus","raw_mean_th","raw_mean_cut"),
               performance_metric = c("TSSmax"), 
               dismo_threshold = c("sensitivity"),
               consensus_level = 0.5,
               png_ensemble = TRUE, 
               write_occs = TRUE,
               write_map = TRUE, 
               scale_models = TRUE,
               uncertainty = TRUE,
               overwrite = T)

