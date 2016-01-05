sidebarLayout(      
  
  # Define the sidebar with inputs
  sidebarPanel(

    
    
    uiOutput("prelayerControls"),

    
    uiOutput("postslotControls"),
    uiOutput("postlayerControls"),

    
    selectInput("season", "Season:", 
                choices=c( '2015-2016', '2014-2015')),
    
    uiOutput("playerSelect"),
    
    
    downloadButton('downloadData', 'Download csv'),
    #helpText("55"),
    
    hr()
    #
  ),
  
  # Create a spot for the waferplot
  
  mainPanel(
    tabsetPanel(type = "tabs", 
                tabPanel("FG%", 
                         fluidPage(
                           fluidRow(
                             column(12, plotOutput("FGpt",width = 640, height = 480))
                           ))),
                
                tabPanel("Shot Selection", 
                         fluidPage(
                           fluidRow(
                             column(12, plotOutput("shotSel",width = 450, height = 400))
                           ),
                           fluidRow( 
                             column(12, plotOutput("shotSelDef",width = 450, height = 400))
                           ))),
                
                tabPanel("Player Value", fluidPage(
                  fluidRow(
                    column(12, plotOutput("value", width = 640, height = 480))
                    )))

    )
  )
  
)