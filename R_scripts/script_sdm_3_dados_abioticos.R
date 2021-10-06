#####################
## dados abioticos ##
#####################

# criar uma janela com a extensao da area de trabalho
ext <- extent(-57, -35, -34, -3)

# carregar as biovariaveis
dados <- list.files(path=paste('D:/Vole/pres', sep=''), pattern='bio', full.names=TRUE )

# ver os arquivos
dados

# agrupar as camadas em um objeto
wclim <- stack(dados)
wclim
# extrair os valores dos pontos nas camadas ambientais
vals <- extract(wclim, rpvole)
summary(vals)

# calcular a os indices de correlacao e niveis de significancia (data.frame)
corrgram(vals, bg='blue', cex=1, pch=21, fig=TRUE, main = "Correlograma", lower.panel=panel.pts, upper.panel=panel.conf)

# biovar <- dropLayer(wclim, c('bio1', 'bio2', 'bio3', 'bio4', 'bio5', 'bio6', 'bio7', 'bio8', 'bio9', 'bio10', 'bio11', 'bio12', 'bio13', 'bio14', 'bio15', 'bio16', 'bio17', 'bio18', 'bio19'))
# deletar a linha acima as variaves selecionadas, perceba que apenas as variaveis descartadas devem permanecer na lista

# selecionar as variaveis (bio3, bio4, bio7, bio12 e bio17)
biovar <- dropLayer(wclim, c('bio1', 'bio2', 'bio5', 'bio6', 'bio7', 'bio9', 'bio10', 'bio11', 'bio13', 'bio14', 'bio15', 'bio16', 'bio18', 'bio19'))
biovar
plot(biovar)

# criar um raster com as camadas selecionadas (biovar.grd) em algum diretorio
writeRaster(biovar, filename="biovar.grd", overwrite=T)

# extrair os valores de biovar de cada ponto usado na modelagem
var <- extract(biovar, pts)

# calcular novamente os indices de correlacao e niveis de significancia (data.frame)
# rcorr(var)
corrgram(var, bg='blue', cex=3, pch=21, fig=TRUE, main = "Correlograma", lower.panel=panel.pts, upper.panel=panel.conf)

# criar o stack com as camadas ambientais selecionadas
pred_nf = stack("biovar.grd")

# verificar as biovariaveis, resolucao, camadas, projecao, etc...
pred_nf

pontos <- pts

# modelagem preliminar Kfold dividi os 106 pontos em 5 grupos de aproximadamente 21(aleatoriamente) e vai dizer que o grupo 1 será os pontos de treino.Isto é 20 % será o treino e 80% modelamos. Isto é para saber o quanto o modelo acertou e errou. Bem como teremos 10000 divididos em 5 grupos 1 de treino(para ausência)
group <- kfold(pontos, 5)
pres_train <- pontos[group != 1, ]
pres_test <- pontos[group == 1, ]
backg <- randomPoints(pred_nf, n=10000, ext=ext, extf = 1.25)
colnames(backg) = c( 'lon' ,  'lat' )
group <- kfold(backg, 5)
backg_train <- backg[group != 1, ]
backg_test <- backg[group == 1, ]

# Este comando dirá para o programa pegar os 20% de treino (que são pontos de presença que eu escondo pra ver se ele captura no mapa a presença deste pontos mesmo emitindo para o programa). Bem como ele terá que acertar os pontos de ausência
bc <- bioclim(pred_nf, pres_train)
e <- evaluate(pres_test, backg_test, bc, pred_nf) 
e
t <- e@t[which.max(e@TPR + e@TNR)]
t
pb <- predict(pred_nf, bc, ext=ext, progress=''  )

t = 0.7 #treshold- corte (corte escolhido por mim) tirar essa linha

bc.t <- pb > t #treshold-corte (escolhido pelo programa). Indicar o melhor modelo repetir 20 vezes



par(mfrow=c(1,2))
plot(pb, main= 'Bioclim')
data(wrld_simpl)
plot(wrld_simpl, xlim=c(-70,-35), ylim=c(-40, 0), axes=TRUE, add=TRUE)

plot(bc.t, main= 'Bioclim (threshold)')
data(wrld_simpl)
plot(wrld_simpl, xlim=c(-50,-36), ylim=c(-25, -10), axes=TRUE, add=TRUE)
points(pontos, bg='blue', cex=0.5, pch=21)

plot(e, 'ROC')


# fim da pratica 02

