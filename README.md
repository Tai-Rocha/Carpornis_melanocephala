# Carpornis_melanocephala
This is a scripts repository of manuscript to be submitted
, entitled "Priority areas for the search of Carpornis melanocephala (Passeriformes: Cotingidae) in Rio de Janeiro State,Brazil"

Here we use ecological niche models analysis to map suitability climatic condition for Black-headed berryeater ( Carpornis melanocephala) in Rio de Janeiro state. Our goal it's find new  populations in future fieldwork.

Script folders was divided subfolder as follow:
Exploratory analysis : to study the georeferenced data in all climatic variables which we use in this study (http://www.worldclim.com/version2 in 30 seconds resolution (~1 km²))

Pearson_Correlation: to verify the pairwise variables correlation

Data cleaning: filters to applie on records dataset in order to reduce sample bias (reduce spatial correlation). Here, we use setupsdma_data funtion of modleR package (https://model-r.github.io/modleR/)

Crop_M_BAM_Area: Crop M BAM area  (see  Barve et al 2011, https://www.researchgate.net/publication/230691635_The_crucial_role_of_the_accessible_area_in_ecological_niche_modeling_and_species_distribution_modeling )

Bioclim_for_PA: We run a BIOCLIM algorithm to select pseudoabsence area

ENMs: workflow based on modleR to performing ecological niche momodleR package to performing ecological niche model.
We have two subfolder 1- for models based on 4 climatic vriables  and 2- for models based on 6 climatic variables.

BoxPlots: 1 - Boxplots of variables in record database 2- Boxplot of models evaluation metrics
