library(shiny)
library(lubridate)

fecha_2y <- Sys.Date() - years(2) - weeks(1)
fecha_1y <- Sys.Date() - years(1) - weeks(1)  
fecha_6m <- Sys.Date() - months(6) - weeks(1)

shinyUI(
  fluidPage(theme = 'slate.css',
    titlePanel('Panel de consulta'),
    sidebarLayout(
      sidebarPanel(
        
        tags$h3('Menú de opciones'),
        selectInput('simbolo', 'Símbolo IPC', 
                    c('AC' = 'BMV:AC',
                      'ALFA.A' = 'BMV:ALFAA',
                      'ALSEA' = 'BMV:ALSEA',
                      'AMX.L' = 'BMV:AMXL',
                      'ASUR.B' = 'BMV:ASURB')),
        selectInput('fecha', 'Periodo', 
                    list('2 años' = fecha_2y,
                      '1 año' = fecha_1y,
                      '6 meses' = fecha_6m),
                    selected = '1 año')
        ),
      mainPanel(
        plotOutput("graph1", height = 600)
      )
    )
  )
)