library(shiny)
library(quantmod)

# Simulation and Shiny Application of Flue Season Dynamics
shinyServer(function(input, output) {
  
  exportar_serie <- reactive({
    getSymbols.google(input$simbolo, from = input$fecha, auto.assign = F)
  })
  
  output$graph1 <- renderPlot({
    datos <- exportar_serie()
    layout(matrix(1:3, nrow = 3, ncol = 1), heights = c(4, 3, 3))
    chartSeries(datos, type = 'line',
                TA = "addMACD();addSMA(n = 15, col = 'orange2');addMomentum(n = 15)",
                layout = NULL, up.col = 'steelblue2', name = '')
    
  })
  
})