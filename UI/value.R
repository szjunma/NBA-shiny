sidebarLayout(      
  
  # Define the sidebar with inputs
  sidebarPanel(
    
#     selectInput("season", "Season:", 
#                 choices=c( '2015-2016', '2014-2015')),
    
    uiOutput("playerSelectMulti"),
    
    
    downloadButton('downloadData', 'Download csv'),
    hr()
    #
  ),
  
  mainPanel(
    tabsetPanel(type = "tabs", 

                tabPanel("Offense", fluidPage(
                  fluidRow(
                    column(12, plotOutput("value", width = 640, height = 480))
                  )))
                
    )
  )
  
)