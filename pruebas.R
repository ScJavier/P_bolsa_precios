
library(shiny)
runGitHub('P_bolsa_precios', 'ScJavier')


library(quantmod)
simbolo <- 'BMV:AC'
fecha <- '2016-09-10'
datos <- getSymbols.google(simbolo, from = fecha, auto.assign = F)

library(ggplot2)

datos <- data.frame(datos)
datos$Fecha = as.Date(rownames(datos))
colnames(datos)[4] = 'Precio'

# Media movil

ff <- datos$Fecha
datos$mm <- rep(NA, length(ff))
periodo <- 5
for(j in 5:length(ff))
{
  datos$mm[j] <- mean(datos$Precio[(j-periodo):j])
}

# Gráfica inicial
pp <- ggplot(data = datos, aes(x = Fecha, y = Precio)) +
  geom_line(aes(text = Fecha), col = 'darkcyan', lwd = 0.75) + xlim(min(datos$Fecha), max(datos$Fecha)) +
  geom_line(aes(y = mm), col = 'orange', lwd = 0.75)





# install.packages('plotly')
library(plotly)

ggplotly(pp, tooltip = c('y'))

