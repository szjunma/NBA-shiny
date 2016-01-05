library(shiny)
library(tools)
library(ggplot2)
library(reshape2)
#library(knitr)
library(scales) 
library(dplyr)
library(gridExtra)

rm(list = ls())
source('shotAnalysis.R')
source('init.R')
source('loadData.R')


# Define the UI
ui <- navbarPage('NBA', 
             tabPanel('Shooting Performance', source(file.path("UI", 'ui.R'), local = TRUE)$value),
             tabPanel('Read me', source(file.path("UI", 'readme.R'), local = TRUE)$value)
  )
  

# Define the server code
server <- function(input, output, session) {
  
  source(file.path("Server", 'server.R'), local = TRUE)
  }

# Return a Shiny app object
shinyApp(ui = ui, server = server)