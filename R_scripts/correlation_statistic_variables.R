#####################
## dados abioticos ##
#####################

# passo 1 - carregar as bibliotecas

library(raster)
library(rgeos)
library(rgdal)
library(scales)
library(dismo)
library(maps)
library(gclus)
library(clusterSim)
library(maptools)
library(ggplot2)
library(shapefiles)
require(XML)
require(maptools)
require(RColorBrewer)
require(spdep)
require(RColorBrewer)
require(plotrix)
require(classInt)
library(corrplot)
library(stats)
library(Hmisc)
library(corrgram)
library(ROCR)


# criar uma janela com a extensao da area de trabalho
ext <- extent(-57, -35, -34, -3)

# carregar as biovariaveis
dados <- list.files(path=paste('C:/carpornis/pres', sep=''), pattern='bio', full.names=TRUE )
pts <- read.csv(file.choose(), header=T)

# ver os arquivos
dados

# agrupar as camadas em um objeto
wclim <- stack(dados)
wclim
# extrair os valores dos pontos nas camadas ambientais
vals <- extract(wclim, pts)
summary(vals)

# calcular a os indices de correlacao e niveis de significancia (data.frame)
corrgram(vals, bg='blue', cex=1, pch=21, fig=TRUE, main = "Pearson Correlation 1", lower.panel=panel.pts, upper.panel=panel.conf)

# biovar <- dropLayer(wclim, c('bio1', 'bio2', 'bio3', 'bio4', 'bio5', 'bio6', 'bio7', 'bio8', 'bio9', 'bio10', 'bio11', 'bio12', 'bio13', 'bio14', 'bio15', 'bio16', 'bio17', 'bio18', 'bio19'))
# deletar a linha acima as variaves selecionadas, perceba que apenas as variaveis descartadas devem permanecer na lista

# selecionar as variaveis (bio4, bio12, bio15 e bio20)
biovar <- dropLayer(wclim, c('bio1', 'bio2', 'bio3', 'bio5', 'bio6', 'bio7', 'bio8', 'bio9', 'bio10', 'bio11', 'bio13', 'bio14', 'bio16', 'bio17', 'bio18', 'bio19'))
biovar
plot(biovar)

# criar um raster com as camadas selecionadas (biovar.grd) em algum diretorio
writeRaster(biovar, filename="biovar.grd", overwrite=T)

# extrair os valores de biovar de cada ponto usado na modelagem
var <- extract(biovar, pts)

# calcular novamente os indices de correlacao e niveis de significancia (data.frame)
# rcorr(var)
corrgram(var, bg='blue', cex=3, pch=21, fig=TRUE, main = "Pearson Correlation 2", lower.panel=panel.pts, upper.panel=panel.conf)

# criar o stack com as camadas ambientais selecionadas
pred_nf = stack("biovar.grd")

# verificar as biovariaveis, resolucao, camadas, projecao, etc...
pred_nf

pontos <- pts

### Gerando a tabela com as valores extra?dos
write.table(vals, file="vals.csv", quote=FALSE, sep=';', dec=",")

### Matriz de correla??o de pearson - pacote corrplot e leitura da tabela que foi gerada acima
corrplota <- (read.csv('./vals.csv', sep=";", dec=",", header=TRUE))
corrplota
corrplotall <- cor(corrplota)
corrplot(corrplotall, method="circle", type = 'upper')
View(corrplotall)

write.table(corrplotall, file="corrplotall.csv", quote=FALSE, sep=';', dec=",")



### Fazendo teste de signific?ncia- Visualizar a correl?o pontos/biovari?veis.

corrplotall <- read.csv(file.choose(), sep=";", dec=",", header=TRUE)

cor.mtest <- function(corrplotall, conf.level = 0.95) {
  mat <- as.matrix(corrplotall)
  n <- ncol(corrplotall)
  p.mat <- lowCI.corrplotall <- uppCI.corrplotall <- matrix(NA, n, n)
  diag(p.mat) <- 0
  diag(lowCI.corrplotall) <- diag(uppCI.corrplotall) <- 1
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(corrplotall[, i], corrplotall[, j], conf.level = conf.level)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
      lowCI.corrplotall[i, j] <- lowCI.corrplotall[j, i] <- tmp$conf.int[1]
      uppCI.corrplotall[i, j] <- uppCI.corrplotall[j, i] <- tmp$conf.int[2]
    }
  }
  return(list(p.mat, lowCI.corrplotall, uppCI.corrplotall))
}

res1 <- cor.mtest(corrplotall, 0.95)
res2 <- cor.mtest(corrplotall, 0.99)

corrplot(corrplotall, p.mat = res1[[1]], sig.level = 0.05)
corrplot(corrplotall, p.mat = res1[[1]], insig = "p-value")
corrplot(corrplotall, p.mat = res1[[1]], insig = "p-value", sig.level = -1)
