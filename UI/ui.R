sidebarLayout( 
  # Define the sidebar with inputs
  sidebarPanel(
    selectInput("season", "Season:", 
                choices=c( '2015-2016', '2014-2015')),
    
    uiOutput("playerSelect"),
    
    downloadButton('downloadData', 'Download csv')
  ),
  
  mainPanel(
    tabsetPanel(type = "tabs", 
                tabPanel("FG%", 
                           fluidRow(
                             column(12, plotOutput("FGpt",width = 600, height = 480))
                           )),
                
                tabPanel("Shot Selection", 
                         fluidRow(
                             column(12, plotOutput("shotSel",width = 450, height = 400))
                           ),
                           fluidRow( 
                             column(12, plotOutput("shotSelDef",width = 450, height = 400))
                           )),
                tabPanel("Value", 
                         fluidRow(
                             column(12, plotOutput("value", width = 600, height = 480))
                           ))
    )
  )
)