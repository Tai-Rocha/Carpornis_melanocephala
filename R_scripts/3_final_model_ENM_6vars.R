
finalModels_sp <-final_model(species_name = unique(sp_records$sp),
                 algorithms = NULL, #if null it will take all the algorithms in disk
                 scale_models = FALSE,
                 models_dir = "./results_final_6vars",
                 sensitivity = 0.9,
                 which_models = c("raw_mean","bin_mean","bin_consensus","raw_mean_th","raw_mean_cut"),
                 mean_th_par = c("sensitivity"),
                 final_dir = "final_models",
                 consensus_level = 0.5,
                 png_final= TRUE,
                 uncertainty = TRUE,
                 proj_dir = "current_6vars",
                 overwrite = TRUE)