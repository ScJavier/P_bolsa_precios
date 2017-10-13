library(shiny)
library(quantmod)
library(dygraphs)
library(dplyr)
library(lubridate)

fecha_5y <- Sys.Date() - years(5) - weeks(1)
fecha_2y <- Sys.Date() - years(2) - weeks(1)
fecha_1y <- Sys.Date() - years(1) - weeks(1)  
fecha_6m <- Sys.Date() - months(6) - weeks(1)

shinyUI(
  fluidPage(theme = 'cosmo.css',
    title = 'Panel de consulta',
    fluidRow(
      column(2,
             h3('Menú de opciones'),
             selectInput('simbolo', 'Símbolo IPC', 
                         c('AC' = 'BMV:AC',
                           'ALFA.A' = 'BMV:ALFAA',
                           'ALSEA' = 'BMV:ALSEA',
                           'AMX.L' = 'BMV:AMXL',
                           'ASUR.B' = 'BMV:ASURB'),
                         selectize = T),
             selectInput('fecha', 'Periodo', 
                         list('5 años' = fecha_5y,
                              '2 años' = fecha_2y,
                              '1 año' = fecha_1y,
                              '6 meses' = fecha_6m),
                         selectize = T, selected = fecha_1y),
             numericInput('MA_n', 'Media movil (n)', value = 15,
                          min = 1, max = 30, step = 1)
      ),
      
      column(6,
          dygraphOutput("graph1")
      ),
      
      column(4,
          tags$h4('Tendencia 15 días'),
          verbatimTextOutput('tendencia15'),
          tags$h4('Tendencia 30 días'),
          verbatimTextOutput('tendencia30')
      )
    ),
    
    hr(),
    
    fluidRow(
      column(2,
          numericInput('Mom_n', 'Momentum (n)', value = 15,
                        min = 1, max = 30, step = 1)
      ),
      
      column(6,
          dygraphOutput("graph2")
      ),
      
      column(4,
          tags$h4('Media móvil'),
          verbatimTextOutput('mediamovil')
      )
    )
    
  )
)