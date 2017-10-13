library(shiny)
library(quantmod)
library(dygraphs)
library(dplyr)
library(lubridate)

# input <- list(simbolo = 'BMV:ALFAA', fecha = Sys.Date() - years(2) - weeks(1))

# Simulation and Shiny Application of Flue Season Dynamics
shinyServer(function(input, output) {
  
  exportar_serie <- reactive({
    getSymbols.google(input$simbolo, from = input$fecha, auto.assign = F)
  })

  
  output$tendencia15 <- renderText({
    datos <- exportar_serie()
    y <- tail(datos[, 4], 15); x <- 1:15
    tendencia <- coef(lm(y ~ x))[2]
    if (anova(lm(y ~ x))[[5]][1] > 0.1)
    {
      return('Sin tendencia')
    } else
    {
     if (tendencia > 0)
     {
       return('Tendencia alcista')
     } else
     {
        return('Tendencia bajista') 
     }
    }
  })
  
  
  output$tendencia30 <- renderText({
    datos <- exportar_serie()
    y <- tail(datos[, 4], 30)
    x <- 1:30
    tendencia <- coef(lm(y ~ x))[2]
    if (anova(lm(y ~ x))[[5]][1] > 0.1)
    {
      return('Sin tendencia')
    } else
    {
      if (tendencia > 0)
      {
        return('Tendencia alcista')
      } else
      {
        return('Tendencia bajista') 
      }
    }
  })
  
  
  output$mediamovil <- renderText({
    datos <- exportar_serie()
    datos$MM <- SMA(datos[, 4], n = input$MA_n)
    dat_aux <- tail(datos[, c(4, 6)], 1)
    res <- 100*(dat_aux[1, 1] - dat_aux[1, 2])/dat_aux[1, 1]
    return(res)
  })
  

  output$graph1 <- renderDygraph({
    datos <- exportar_serie()
    dat_aux <- data.frame(Precio = datos[,paste0(input$simbolo, '.Close')],
                          MV = SMA(datos[,paste0(input$simbolo, '.Close')], n = input$MA_n))
    names(dat_aux) <- c('Precio', 'MV')
    dygraph(dat_aux, main = input$simbolo) %>%
      dyRangeSelector()
  })
  
  
  output$graph2 <- renderDygraph({
    datos <- exportar_serie()
    dat_aux <- momentum(datos[,paste0(input$simbolo, '.Close')], n = input$Mom_n)
    dat_aux$MA_Mom <- SMA(dat_aux, 15)
    names(dat_aux) <- c('Momentum', 'MV')
    dygraph(dat_aux, main = 'Momentum') %>%
      dyRangeSelector()
  })
  
})
