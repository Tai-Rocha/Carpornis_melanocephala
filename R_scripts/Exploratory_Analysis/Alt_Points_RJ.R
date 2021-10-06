###################################
## Exploratory Alt points in Coord 
## Authos: Tainá Rocha
## Date : 05 October 2021
## R version 4.1.1
###################################


## Library

library(raster)
library(rgdal)
library(xlsx)
library(sp)
library(tidyverse)

table <- xlsx::read.xlsx("./data/Carpornis final _Revisado_5maio_2020.xlsx", 1)


alt <- raster::raster("./data/Asc/alt.asc", patterns = ".asc")
plot(alt)

rj_points<-  filter(table, estado=="RJ") |> 
             relocate(lat, .after = long)

write_csv(rj_points, "./data/rj_alt_points.csv")


rj_alt_points <- raster::extract(alt, rj_points[3:4])
                    
boxplot(rj_alt_points)

rj_alt_points
