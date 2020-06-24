#ativar o pacote ggplot2. Pode ser pelo comando library(ggplot2) ou manualmente no
library(ggplot2)

#canto direiro inferior, aba "Packages".



#No script abaixo, "MD_AUC"  o nome que dei pra planilha ao abrir aqui,

#Footprint = nome da coluna em quest?o
# Comando Para apargar arquivos: 
rm(KAPPA) 


#(1) Basic boxplot

AUC <- read.csv(file.choose(), header=T)

AUC <- ggplot(AUC, aes(x = Algorithm, y = AUC)) +
  
  geom_boxplot()

AUC

AUC <- AUC + scale_y_continuous(name = "AUC", breaks=seq(0,1), limits=c(0,1))

AUC

###########################################################


#(1) Basic boxplot

PROCc <- read.csv(file.choose(), header=T)

PROCc <- ggplot(PROCc, aes(x = Algorithm, y = pROC)) +
  
  geom_boxplot()

PROCc

PROCc <- PROCc + scale_y_continuous(name = "pROC", breaks=seq(0,2), limits=c(0,1.5))

PROCc

#(1) Basic boxplot

TSS <- read.csv(file.choose(), header=T)

TSS <- ggplot(TSS, aes(x = Algorithms, y = TSS)) +
  
  geom_boxplot()

TSS

TSS <- TSS + scale_y_continuous(name = "TSS", breaks=seq(0,1), limits=c(0,1))

TSS

