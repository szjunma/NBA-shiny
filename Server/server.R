output$playerSelect <- renderUI({
  if(is.null(input$season))     {return(NULL) }
  else if (input$season == '2014-2015'){  player.info <- read.csv('data/2014-2015player.csv', header = T, stringsAsFactors = F)
} else if (input$season == '2015-2016'){  player.info <- read.csv('data/2015-2016player.csv', header = T, stringsAsFactors = F)}
  
  name <- player.info %>%
    select(PLAYER_NAME) %>%
    arrange(PLAYER_NAME)
  
  selectInput("player", "Player", 
              choices=c('League Average', name))
  
})


shot.pt <- reactive({
  if (input$player == 'League Average' & input$season == '2014-2015') {shot.pt <- league.1415}
  else if (input$player == 'League Average' & input$season == '2015-2016') {shot.pt <- league.1516}
  else if (input$player != 'League Average' & input$season == '2014-2015'){shot.pt <- shotAnalysis(filter(shot.1415, playerName == input$player))}
  else if (input$player != 'League Average' & input$season == '2015-2016'){shot.pt <- shotAnalysis(filter(shot.1516, playerName == input$player))}
  
})


output$FGpt <- renderPlot({
  
  if(is.null(input$player))     {return(NULL) }
  
  shot.pt <- shot.pt()
  
  shot.plot <- ggplot(shot.pt, aes(x = ShotDist, y = `FG%`, fill = factor(DefDist))) + 
    geom_bar(stat = "identity",  position = position_dodge(width = .9), width = 0.6) + 
    ylab('FG%') + xlab('Shot Distance (ft)') + ylim(0, 1) +
    geom_text(aes(label = paste(totalFGM, '/', totalFGA, sep = '')), position = position_dodge(width = .9), vjust = -0.5, size =3) +
    scale_x_discrete(limits=unique(shot.pt()$ShotDist))+
    theme_tws(base_size = 15) + scale_fill_discrete(name="Defender\nDistance (ft)")+
    theme(legend.position = c(0.65, 0.85))
  
  if ( input$season == '2014-2015') {shot.plot <- shot.plot + 
    geom_bar(aes(x = league.1415$ShotDist, y = league.1415$`FG%`, fill = factor(DefDist)), 
             stat = "identity", position = position_dodge(width = .9), width = 0.9, alpha = 0.5, show.legend = FALSE) + 
    title_with_subtitle(paste(input$player, 'vs League Average FG% '), paste('Season', input$season))}
  else if ( input$season == '2015-2016') {shot.plot <- shot.plot + 
    geom_bar(aes(x = league.1516$ShotDist, y = league.1516$`FG%`, fill = factor(DefDist)), 
             stat = "identity", position = position_dodge(width = .9), width = 0.9, alpha = 0.5, show.legend = FALSE) + 
    title_with_subtitle(paste(input$player, 'vs League Average FG% '), paste('Season', input$season, ', as of 01/03/2016')) }
 
  shot.plot

  
})


output$shotSel <- renderPlot({
  if(is.null(input$player) )  {return(NULL) } else {}
  
  shot.pt <- shot.pt()
  shotSel.dist <<- aggregate(totalFGA ~ ShotDist, shot.pt, sum)[c(1, 8, 2:7),]
  shotSel.dist <<- mutate(shotSel.dist, perc = totalFGA/sum(totalFGA), y.breaks = cumsum(perc) - perc/2)
  
  if ( input$season == '2014-2015') {sel <- ggplot() + 
    geom_bar(aes(x = factor(1), y = shotSel.dist.1415$perc, fill = shotSel.dist.1415$ShotDist ), width = 1.2, stat="identity", alpha = 0.6) + 
    scale_y_continuous(breaks = shotSel.dist.1415$y.breaks[-8], labels=percent(shotSel.dist.1415$perc)[-8] )
  }
  else if ( input$season == '2015-2016') {sel <- ggplot() + 
    geom_bar(aes(x = factor(1), y = shotSel.dist.1516$perc, fill = shotSel.dist.1516$ShotDist ), width = 1.2, stat="identity", alpha = 0.6) + 
    scale_y_continuous(breaks = shotSel.dist.1516$y.breaks[-8], labels=percent(shotSel.dist.1516$perc)[-8] )}
  
  
  sel <- sel  + geom_bar(aes(x = factor(1), y = shotSel.dist$perc, fill = shotSel.dist$ShotDist ), width = 1, stat="identity") +
    scale_fill_discrete(breaks=shotSel.dist$ShotDist, name="Shot \nDistance (ft)") +
    coord_polar(theta="y") + theme_tws(base_size = 15) + 
    geom_text(aes(x = factor(1), y=shotSel.dist[shotSel.dist$perc > 0.02,]$y.breaks, 
                  label=percent(shotSel.dist[shotSel.dist$perc > 0.02,]$perc)), size = 4)+
    title_with_subtitle(paste(input$player, 'Shot Selection '), paste('- Distance to Basket, Season', input$season)) +
    theme(axis.ticks=element_blank(), axis.title=element_blank(), axis.text.y=element_blank(),
          panel.border = element_blank(),
          panel.grid.major = element_line(colour = "#f4f4f4", size = 0.25),
          panel.grid.minor = element_line(colour = "#f4f4f4", size = 0.25),
          legend.key = element_blank())
  

  
  sel
  
})

output$shotSelDef <- renderPlot({
  if(is.null(input$player) )  {return(NULL) } else {}
  
  shot.pt <- shot.pt()
  shotSel.def <<- aggregate(totalFGA ~ DefDist, shot.pt, sum)
  shotSel.def <<- mutate(shotSel.def, perc = totalFGA/sum(totalFGA), y.breaks = cumsum(perc) - perc/2)
  
  if ( input$season == '2014-2015') {def <- ggplot() + 
    geom_bar(aes(x = factor(1), y = shotSel.def.1415$perc, fill = shotSel.def.1415$DefDist ), width = 1.2, stat="identity", alpha = 0.6) + 
    scale_y_continuous(breaks = shotSel.def.1415$y.breaks, labels=percent(shotSel.def.1415$perc))
  }
  else if ( input$season == '2015-2016') {def <- ggplot() + 
    geom_bar(aes(x = factor(1), y = shotSel.def.1516$perc, fill = shotSel.def.1516$DefDist ), width = 1.2, stat="identity", alpha = 0.6) + 
    scale_y_continuous(breaks = shotSel.def.1516$y.breaks, labels=percent(shotSel.def.1516$perc))}
  
  def <- def + 
    scale_fill_discrete(breaks=shotSel.def$DefDist, name="Defender\nDistance (ft)") +
    #geom_bar(aes(x = factor(1), y = shotSel.def.1415$perc, fill = shotSel.def.1415$DefDist ), width = 1.2, stat="identity", alpha = 0.6) + 
    coord_polar(theta="y") +
    geom_bar(aes(x = factor(1), y = shotSel.def$perc, fill = shotSel.def$DefDist ), width = 1, stat="identity") +
    theme_tws(base_size = 15) + 
    geom_text(aes(x = factor(1), y=shotSel.def[shotSel.def$perc > 0.02,]$y.breaks, label=percent(shotSel.def[shotSel.def$perc > 0.02,]$perc)), size = 4)+
    #scale_y_continuous(breaks = shotSel.def.1415$y.breaks, labels=percent(shotSel.def.1415$perc) )+
    title_with_subtitle(paste(input$player, 'Shot Selection '), paste('- Distance to Defender, Season', input$season)) +
    theme(axis.ticks=element_blank(),  
          axis.title=element_blank(), 
          axis.text.y=element_blank(),
          panel.border = element_blank(),
          panel.grid.major = element_line(colour = "#f4f4f4", size = 0.25),
          panel.grid.minor = element_line(colour = "#f4f4f4", size = 0.25),
          legend.key = element_blank())
  def
  
})



output$value <- renderPlot({
  if(is.null(input$player) | input$player == 'League Average')  {return(value.plot.1516) } else {show.name <<- input$player}

  if ( input$player != 'League Average' & input$season == '2014-2015') {
    
    value.plot <- value.plot.1415 +
      geom_text(aes(value.1415[value.1415$name == show.name,]$FGA, value.1415[value.1415$name == show.name,]$PtsDiff), 
                label = value.1415[value.1415$name == show.name,]$name, size = 4,hjust=0.5, vjust=-0.6) + 
      geom_point(aes(value.1415[value.1415$name == show.name,]$FGA, value.1415[value.1415$name == show.name,]$PtsDiff), size = 4, color = 'red')
    }
  
  else if ( input$player != 'League Average' & input$season == '2015-2016') {
   
    value.plot <- value.plot.1516 +
      geom_text(aes(value.1516[value.1516$name == show.name,]$FGA, value.1516[value.1516$name == show.name,]$PtsDiff), 
                label = value.1516[value.1516$name == show.name,]$name, size = 4,hjust=0.5, vjust=-0.6) +
      geom_point(aes(value.1516[value.1516$name == show.name,]$FGA, value.1516[value.1516$name == show.name,]$PtsDiff), size = 4, color = 'red')
  }
  
  value.plot
  
})






