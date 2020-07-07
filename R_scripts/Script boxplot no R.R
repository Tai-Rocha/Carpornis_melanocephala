#Seguindo http://t-redactyl.io/blog/2016/04/creating-plots-in-r-using-ggplot2-part-10-boxplots.html



#ativar o pacote ggplot2. Pode ser pelo comando library(ggplot2) ou manualmente no

#canto direiro inferior, aba "Packages".



#No script abaixo, "meusdados" ? o nome que dei pra planilha ao abrir aqui,

#Footprint = nome da coluna em quest?o



#(1) Basic boxplot



MD_1 <- ggplot(MD_TSS, aes(x = Algorithm, y = TSS)) +

  geom_boxplot()

p10



#(2) Customising axis labels



p10 <- p10 + scale_x_discrete(name = "Scenario") +

  scale_y_continuous(name = "Human footprint on water quality (% contamination)")

p10



#(3) Changing axis ticks



p10 <- p10 + scale_y_continuous(name = "Human footprint on water quality (% contamination)",

                                breaks = seq(0, 60, 10),

                                limits=c(0, 60))

p10



#(4) Adding a title



p10 <- p10 + ggtitle("Boxplot of footprint by scenario")

p10



#(5) Changing the colour of the boxes (yellow)



fill <- "gold1"

line <- "goldenrod2"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint)) +

  geom_boxplot(fill = fill, colour = line) +

  scale_y_continuous(name = "Human footprint on water quality (% contamination)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of footprint by scenario")

p10



#(6)  Changing the colour again (blue)



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint)) +

  geom_boxplot(fill = fill, colour = line) +

  scale_y_continuous(name = "Human footprint on water quality (% contamination)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of footprint by scenario")

p10



#(7) specifying the degree of transparency in the box fill are



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint)) +

  geom_boxplot(fill = fill, colour = line, alpha = 0.7) +

  scale_y_continuous(name = "Human footprint on water quality (% contamination)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of footprint by scenario")

p10



#(8) Changing the colour of the outlier



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint)) +

  geom_boxplot(fill = fill, colour = line, alpha = 0.7, outlier.colour = "#1F3552", outlier.shape = 20) +

  scale_y_continuous(name = "Human footprint on water quality (% contamination)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of footprint by scenario")

p10



#(9) Categorizando



meusdados$Climate_Change <- factor(ifelse(meusdados$Climate_Change > mean(meusdados$Climate_Change), 1, 0),

                                   labels = c("not stacked", "stacked"))



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint, fill = Climate_Change)) +

  geom_boxplot(alpha = 0.7) +

  scale_y_continuous(name = "Human footprint on water quality (% contamination)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of footprint by scenario") +

  scale_fill_brewer(palette = "Accent")

p10



#(10) fundo branco



p10 <- p10 + theme_bw()

p10



#(11) fundo branco e somente as linhas de eixos



p10 <- p10 + theme(axis.line.x = element_line(size = 0.5, colour = "black"),

                   axis.line.y = element_line(size = 0.5, colour = "black"),

                   panel.border = element_blank())

p10





#F

#O

#O

#T

#D



#(1) Basic boxplot



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint_D)) +

  geom_boxplot()

p10



#(2) Customising axis labels



p10 <- p10 + scale_x_discrete(name = "Scenario") +

  scale_y_continuous(name = "Human footprint on water quality (diarrhoea-relevant; % contamination)")

p10



#(3) Changing axis ticks



p10 <- p10 + scale_y_continuous(name = "Human footprint on water quality (diarrhoea-relevant; % contamination)",

                                breaks = seq(0, 60, 10),

                                limits=c(0, 60))

p10



#(4) Adding a title



p10 <- p10 + ggtitle("Boxplot of footprint_D by scenario")

p10



#(5) Changing the colour of the boxes (yellow)



fill <- "gold1"

line <- "goldenrod2"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint_D)) +

  geom_boxplot(fill = fill, colour = line) +

  scale_y_continuous(name = "Human footprint on water quality (diarrhoea-relevant; % contamination)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of footprint_D by scenario")

p10



#(6)  Changing the colour again (blue)



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint_D)) +

  geom_boxplot(fill = fill, colour = line) +

  scale_y_continuous(name = "Human footprint on water quality (diarrhoea-relevant; % contamination)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of footprint_D by scenario")

p10



#(7) specifying the degree of transparency in the box fill are



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint_D)) +

  geom_boxplot(fill = fill, colour = line, alpha = 0.7) +

  scale_y_continuous(name = "Human footprint on water quality (diarrhoea-relevant; % contamination)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of footprint_D by scenario")

p10



#(8) Changing the colour of the outlier



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint_D)) +

  geom_boxplot(fill = fill, colour = line, alpha = 0.7, outlier.colour = "#1F3552", outlier.shape = 20) +

  scale_y_continuous(name = "Human footprint on water quality (diarrhoea-relevant; % contamination)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of footprint_D by scenario")

p10



#(9) Categorizando



meusdados$Climate_Change <- factor(ifelse(meusdados$Climate_Change > mean(meusdados$Climate_Change), 1, 0),

                                   labels = c("not stacked", "stacked"))



p10 <- ggplot(meusdados, aes(x = Scenario, y = Footprint_D, fill = Climate_Change)) +

  geom_boxplot(alpha = 0.7) +

  scale_y_continuous(name = "Human footprint on water quality (diarrhoea-relevant; % contamination)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of footprint_D by scenario") +

  scale_fill_brewer(palette = "Accent")

p10



#(10) fundo branco



p10 <- p10 + theme_bw()

p10



#(11) fundo branco e somente as linhas de eixos



p10 <- p10 + theme(axis.line.x = element_line(size = 0.5, colour = "black"),

                   axis.line.y = element_line(size = 0.5, colour = "black"),

                   panel.border = element_blank())

p10





#W

#A

#T

#E

#R

#

#S

#T

#R

#E

#S

#S







#(1) Basic boxplot



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Stress)) +

  geom_boxplot()

p10



#(2) Customising axis labels



p10 <- p10 + scale_x_discrete(name = "Scenario") +

  scale_y_continuous(name = "Annual mean water stress (% of demand unavailable))")

p10



#(3) Changing axis ticks



p10 <- p10 + scale_y_continuous(name = "Annual mean water stress (% of demand unavailable)",

                                breaks = seq(0, 60, 10),

                                limits=c(0, 60))

p10



#(4) Adding a title



p10 <- p10 + ggtitle("Boxplot of water stress by scenario")

p10



#(5) Changing the colour of the boxes (yellow)



fill <- "gold1"

line <- "goldenrod2"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Stress)) +

  geom_boxplot(fill = fill, colour = line) +

  scale_y_continuous(name = "Annual mean water stress (% of demand unavailable)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of water stress by scenario")

p10



#(6)  Changing the colour again (blue)



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Stress)) +

  geom_boxplot(fill = fill, colour = line) +

  scale_y_continuous(name = "Annual mean water stress (% of demand unavailable)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of water stress by scenario")

p10



#(7) specifying the degree of transparency in the box fill are



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Stress)) +

  geom_boxplot(fill = fill, colour = line, alpha = 0.7) +

  scale_y_continuous(name = "Annual mean water stress (% of demand unavailable)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of water stress by scenario")

p10



#(8) Changing the colour of the outlier



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Stress)) +

  geom_boxplot(fill = fill, colour = line, alpha = 0.7, outlier.colour = "#1F3552", outlier.shape = 20) +

  scale_y_continuous(name = "Annual mean water stress (% of demand unavailable)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of water stress by scenario")

p10



#(9) Categorizando



meusdados$Climate_Change <- factor(ifelse(meusdados$Climate_Change > mean(meusdados$Climate_Change), 1, 0),

                                   labels = c("not stacked", "stacked"))



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Stress, fill = Climate_Change)) +

  geom_boxplot(alpha = 0.7) +

  scale_y_continuous(name = "Annual mean water stress (% of demand unavailable)",

                     breaks = seq(0, 60, 10),

                     limits=c(0, 60)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of water stress by scenario") +

  scale_fill_brewer(palette = "Accent")

p10



#(10) fundo branco



p10 <- p10 + theme_bw()

p10



#(11) fundo branco e somente as linhas de eixos



p10 <- p10 + theme(axis.line.x = element_line(size = 0.5, colour = "black"),

                   axis.line.y = element_line(size = 0.5, colour = "black"),

                   panel.border = element_blank())

p10







#W

#A

#T

#E

#R

#

#B

#A

#L

#A

#N

#C

#E







#(1) Basic boxplot



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Balance)) +

  geom_boxplot()

p10



#(2) Customising axis labels



p10 <- p10 + scale_x_discrete(name = "Scenario") +

  scale_y_continuous(name = "Annual total water balance (mm/yr))")

p10



#(3) Changing axis ticks



p10 <- p10 + scale_y_continuous(name = "Annual total water balance (mm/yr)",

                                breaks = seq(0, 3000, 500),

                                limits=c(0, 3000))

p10



#(4) Adding a title



p10 <- p10 + ggtitle("Boxplot of water balance by scenario")

p10



#(5) Changing the colour of the boxes (yellow)



fill <- "gold1"

line <- "goldenrod2"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Balance)) +

  geom_boxplot(fill = fill, colour = line) +

  scale_y_continuous(name = "Annual total water balance (mm/yr)",

                     breaks = seq(0, 3000, 500),

                     limits=c(0, 3000)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of water balance by scenario")

p10



#(6)  Changing the colour again (blue)



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Balance)) +

  geom_boxplot(fill = fill, colour = line) +

  scale_y_continuous(name = "Annual total water balance (mm/yr)",

                     breaks = seq(0, 3000, 500),

                     limits=c(0, 3000)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of water balance by scenario")

p10



#(7) specifying the degree of transparency in the box fill are



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Balance)) +

  geom_boxplot(fill = fill, colour = line, alpha = 0.7) +

  scale_y_continuous(name = "Annual total water balance (mm/yr)",

                     breaks = seq(0, 3000, 500),

                     limits=c(0, 3000)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of water balance by scenario")

p10



#(8) Changing the colour of the outlier



fill <- "#4271AE"

line <- "#1F3552"



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Balance)) +

  geom_boxplot(fill = fill, colour = line, alpha = 0.7, outlier.colour = "#1F3552", outlier.shape = 20) +

  scale_y_continuous(name = "Annual total water balance (mm/yr)",

                     breaks = seq(0, 3000, 500),

                     limits=c(0, 3000)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of water balance by scenario")

p10



#(9) Categorizando



meusdados$Climate_Change <- factor(ifelse(meusdados$Climate_Change > mean(meusdados$Climate_Change), 1, 0),

                                   labels = c("not stacked", "stacked"))



p10 <- ggplot(meusdados, aes(x = Scenario, y = Water_Balance, fill = Climate_Change)) +

  geom_boxplot(alpha = 0.7) +

  scale_y_continuous(name = "Annual total water balance (mm/yr)",

                     breaks = seq(0, 3000, 500),

                     limits=c(0, 3000)) +

  scale_x_discrete(name = "Scenario") +

  ggtitle("Boxplot of water balance by scenario") +

  scale_fill_brewer(palette = "Accent")

p10



#(10) fundo branco



p10 <- p10 + theme_bw()

p10



#(11) fundo branco e somente as linhas de eixos



p10 <- p10 + theme(axis.line.x = element_line(size = 0.5, colour = "black"),

                   axis.line.y = element_line(size = 0.5, colour = "black"),

                   panel.border = element_blank())

p10





