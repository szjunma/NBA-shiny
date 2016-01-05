shotAnalysis <- function(shot.df = data.frame()){
  
  longest.dist <- seq(5, 40, by = 5)
  close.dist <- seq(2,8, by = 2)

  shot.pt <- data.frame()
  
  for (dist in longest.dist){
    
    shot.pt.def <- data.frame()
    
    if (dist != max(longest.dist)){
      for (def.dist in close.dist){
        if (def.dist !=8){    
          shot.pt.def.temp <- shot.df %>%
            filter(SHOT_DIST >=(dist -5) & SHOT_DIST < dist & CLOSE_DEF_DIST >= (def.dist -2) &  CLOSE_DEF_DIST < def.dist) %>%
            summarise(FGP = mean(FGM), totalFGA = sum(!is.na(FGM)), totalFGM = sum(FGM==1), 
                      Pts = sum(PTS), twopt = sum(PTS_TYPE ==2)/(sum(PTS_TYPE ==2)+sum(PTS_TYPE ==3)))
          
          colnames(shot.pt.def.temp) <- c('FG%', 'totalFGA', 'totalFGM', 'Pts', '2pt/total')
          
          shot.pt.def.temp <- mutate(shot.pt.def.temp, 
                                     DefDist = paste(def.dist-2, '-', def.dist, sep = ' '))
          
          shot.pt.def <- rbind(shot.pt.def, shot.pt.def.temp)
        } else {
          shot.pt.def.temp <- shot.df %>%
            filter(SHOT_DIST >=(dist -5) & SHOT_DIST < dist & CLOSE_DEF_DIST >= (def.dist -2)) %>%
            summarise(FGP = mean(FGM), totalFGA = sum(!is.na(FGM)), totalFGM = sum(FGM==1) , 
                      Pts = sum(PTS), twopt = sum(PTS_TYPE ==2)/(sum(PTS_TYPE ==2)+sum(PTS_TYPE ==3)))
          
          colnames(shot.pt.def.temp) <- c('FG%', 'totalFGA', 'totalFGM', 'Pts', '2pt/total')
          
          shot.pt.def.temp <- mutate(shot.pt.def.temp, 
                                     DefDist = paste(def.dist-2, '+', sep = ' '))
          
          shot.pt.def <- rbind(shot.pt.def, shot.pt.def.temp)
          
        }
      }
      
      shot.pt.def <- mutate(shot.pt.def, ShotDist = paste(dist-5, '-', dist, sep = ' '))
      shot.pt <- rbind(shot.pt, shot.pt.def)
      
    } else {
      
      for (def.dist in close.dist){
        if (def.dist !=8){    
          shot.pt.def.temp <- shot.df %>%
            filter(SHOT_DIST >=(dist -5) & CLOSE_DEF_DIST >= (def.dist -2) &  CLOSE_DEF_DIST < def.dist) %>% 
            summarise(FGP = mean(FGM), totalFGA = sum(!is.na(FGM)), totalFGM = sum(FGM==1) , 
                      Pts = sum(PTS), twopt = sum(PTS_TYPE ==2)/(sum(PTS_TYPE ==2)+sum(PTS_TYPE ==3)))
          
          colnames(shot.pt.def.temp) <- c('FG%', 'totalFGA', 'totalFGM', 'Pts', '2pt/total')
          
          shot.pt.def.temp <- mutate(shot.pt.def.temp, 
                                     DefDist = paste(def.dist-2, '-', def.dist, sep = ' '))
          
          shot.pt.def <- rbind(shot.pt.def, shot.pt.def.temp)
        } else {
          shot.pt.def.temp <- shot.df %>%
            filter(SHOT_DIST >=(dist -5) & CLOSE_DEF_DIST >= (def.dist -2)) %>% 
            summarise(FGP = mean(FGM), totalFGA = sum(!is.na(FGM)), totalFGM = sum(FGM==1) , 
                      Pts = sum(PTS), twopt = sum(PTS_TYPE ==2)/(sum(PTS_TYPE ==2)+sum(PTS_TYPE ==3)))
          
          colnames(shot.pt.def.temp) <- c('FG%', 'totalFGA', 'totalFGM', 'Pts', '2pt/total')
          
          shot.pt.def.temp <- mutate(shot.pt.def.temp, 
                                     DefDist = paste(def.dist-2, '+', sep = ' '))
          
          shot.pt.def <- rbind(shot.pt.def, shot.pt.def.temp)
          
        }
      }
      
      shot.pt.def <- mutate(shot.pt.def, ShotDist = paste(dist-5, '+',sep = ' '))
      shot.pt <- rbind(shot.pt, shot.pt.def)
      
    }
  }
  
  return(shot.pt)
}