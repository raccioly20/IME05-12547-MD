library(psych)
library(tidyverse)

nyc <- read.csv("nyc.csv",header=TRUE)
rest_sp <- nyc
rest_sp <- rest_sp %>% rename(preco=Price, comida=Food, decor=Decor, servico=Service,
                              bairro=East)
rest_sp$preco <- rest_sp$preco * 5
describe(rest_sp[,-(1:2)])

library(caret)
set.seed(21)
y <- rest_sp$preco
indice_teste <- createDataPartition(y, times = 1, p = 0.10, list = FALSE)

conj_treino <- rest_sp %>% slice(-indice_teste)
conj_teste <- rest_sp %>% slice(indice_teste)

str(conj_treino)

pairs.panels(conj_treino[,-(1:2)])

par(mfrow=c(1,1))

mcor <- cor(conj_treino[,-(1:2)])
library(corrplot)
corrplot(mcor, method = "number")

mod1 <- lm(preco ~ comida + decor + servico + bairro, data=conj_treino)
summary(mod1)
confint(mod1)
anova(mod1)
(tval <- qt(1-.05/2, mod1$df))

mod2 <- lm(preco ~ comida + decor + bairro, data=conj_treino)
summary(mod2)

anova(mod2,mod1)

summary(mod1)$adj.r.squared
summary(mod2)$adj.r.squared

sqrt(mean((conj_teste$preco - predict(mod2, conj_teste)) ^ 2)) 
summary(mod2)$sigma


par(mfrow=c(2,2))
plot(mod2)
par(mfrow=c(1,1))

library(car)
residualPlots(mod2)


res_sp_res <- rstandard(mod2)
dados <- cbind(conj_treino[ , c(3,4,5,7)], res_sp_res)

library(patchwork)
g1 <- ggplot(dados, aes(x=comida,y=res_sp_res)) + geom_point() + geom_smooth(se = FALSE) + 
  labs(x = "Comida", y = "Resíduos Padronizados")
g2 <- ggplot(dados, aes(x=decor,y=res_sp_res)) + geom_point() + geom_smooth(se = FALSE) + 
  labs(x = "Decoração", y = "Resíduos Padronizados")
g3 <- ggplot(dados, aes(x=bairro,y=res_sp_res)) + geom_point() + geom_smooth(se = FALSE) + 
  labs(x = "Bairro", y = "Resíduos Padronizados")
g1 + g2 + g3




par(mfrow=c(2,2))
plot(conj_treino$comida,res_sp_res, ylab="Residuos Padronizados")
plot(conj_treino$decor,res_sp_res, ylab="Residuos Padronizados")
plot(conj_treino$bairro,res_sp_res, ylab="Residuos Padronizados")
par(mfrow=c(1,1))


shapiro.test(mod2$residuals)





library(alr4)
avPlot(mod2,"decor", id.n=0)
avPlot(mod2,"comida", id.n=0)
avPlot(mod2,"bairro", id.n=0)


data(fuel2001)
describe(fuel2001)

fuel2001 <- transform(fuel2001,
                      Dlic=1000 * Drivers/Pop,
                      Fuel=1000 * FuelC/Pop,
                      Income = Income,
                      logMiles = log(Miles))
f <- fuel2001[,c(7, 8, 3, 10, 9)] # new data frame
describe(f)
corrplot(cor(f), method = "number")
round(cor(f), 4)
