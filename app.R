library(shiny)
library(tools)
library(ggplot2)
library(scales)
library(dplyr)
library(gridExtra)

rm(list = ls())
source('shotAnalysis.R')
source('loadData.R')
title_with_subtitle <- function(title, subtitle = "") {
  ggtitle(bquote(atop(.(title), atop(.(subtitle)))))
}


# Define the UI
ui <- navbarPage('NBA', 
             tabPanel('Shooting Statistics', source(file.path("UI", 'ui.R'), local = TRUE)$value)
  )
  

# Define the server code
server <- function(input, output, session) {
  source(file.path("Server", 'server.R'), local = TRUE)
  }

# Return a Shiny app object
shinyApp(ui = ui, server = server)