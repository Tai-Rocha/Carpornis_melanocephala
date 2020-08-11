## This is a scripts repository of ecological niche models (ENMs) analysis for Carpornis melanocephala (Passeriformes: Cotingidae) in Rio de Janeiro State,Brazil.
#### Author scripts: Tainá Rocha
#### Here we use ENMs to map suitability climatic condition for Black-headed berryeater (*C.melanocephala*) in Rio de Janeiro state. Our goal it's find new  populations in future fieldwork.


##### Script folders was divided in subfolder as follow:

- [x] Exploratory analysis : to study the georeferenced data in all climatic variables which we use in this study. We use climatic data from Worldclim database (http://www.worldclim.com/version2 in 30 seconds resolution (~1 km²)).

- [x] Pearson_Correlation: to verify the pairwise variables correlation and after choose variables less autocorrelated.

- [x] Data cleaning: filters to applie on records dataset in order to reduce sample bias (reduce spatial correlation). Here, we use setupsdma_data funtion of modleR package (https://model-r.github.io/modleR/)

- [x] Crop_M_BAM_Area: select and crop movement (M) area  (see  Barve et al 2011, https://www.researchgate.net/publication/230691635_The_crucial_role_of_the_accessible_area_in_ecological_niche_modeling_and_species_distribution_modeling )

- [x] Bioclim_for_PA: We run a BIOCLIM algorithm to select pseudoabsence area  i.e, low suitability area to generate pseudoabsen records.

- [x] ENMs: workflow based on modleR package to performing ENMs. We have two subfolder:

    - 4_ENMs_Variables: for models based on 4 climatic vriables  
    - 6_ENMs_Variables: for models based on 6 climatic variables.

- [x] BoxPlots: 
 
    - Boxplots of variables in record database 
    - Boxplot of models evaluation metrics
