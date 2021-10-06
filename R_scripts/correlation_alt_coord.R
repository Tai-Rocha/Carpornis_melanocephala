##########################################################
## Correlation test bewtween Altitude x Longitude
## Author: Tainá Rocha
## Date: 28 April 2020
## Laste update: 
##########################################################


## Library packgs

library(raster)
library(ggplot2)

# load altitude
altitude <- raster("./data/layers/raw_layers/altitude_inpe_br.asc", pattern='asc', full.names=TRUE )
plot(altitude)
alt <- stack(altitude)

# load csv longitudes

points <- read.csv("./data/teste.csv", sep = ",")
pontos <- as.data.frame((points))
p <- pontos[,-1]

plot(alt)
points(pontos, col='blue', pch=20, cex=1)

# extrair os valores dos pontos nas camadas ambientais
vals_alt <- extract(alt, p)
summary(vals_alt)


# Plot

ggcorrplot(correlation, hc.order = TRUE, 
           type = "lower", 
           lab = TRUE, 
           lab_size = 1.5, 
           method="circle", 
           colors = c("tomato2", "white", "springgreen3"), 
           title=" ", 
           ggtheme=theme_classic,
           legend.title="Correlation"
)


ggsave("correlation.tiff", units="in", width=5, height=4, dpi=300, compression = 'lzw')


## extrair os valores dos pontos nas camadas ambientais
altitude_vals <- extract(altitude, long_points)
summary(altitude_vals)


