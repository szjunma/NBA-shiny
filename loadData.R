shot.1415 <<- read.csv('data/2014-2015shot.csv', header = TRUE, stringsAsFactors = FALSE)
shot.1516 <<- read.csv('data/2015-2016shot.csv', header = TRUE, stringsAsFactors = FALSE)

league.1415 <<- shotAnalysis(shot.1415)
league.1516 <<- shotAnalysis(shot.1516)

value.1415 <<- read.csv('data/2014-2015playervalue.csv', header = TRUE, stringsAsFactors = FALSE)
value.1516 <<- read.csv('data/2015-2016playervalue.csv', header = TRUE, stringsAsFactors = FALSE)

value.plot.1516 <<- ggplot() + 
  geom_point(aes(x = value.1516$FGA, y = value.1516$PtsDiff, color = factor(sign(value.1516$PtsDiff))), size = 4, shape = 1) + 
  scale_colour_manual(values=c("#D55E00", "#009E73"))+
  #geom_text(aes(show$FGA, show$FGMDiff), label = show$name, size = 4,hjust=0.5, vjust=-0.6)+
  #geom_point(aes(show$FGA, show$FGMDiff), size = 4)+
  ylab('Value Added by Points Scored') + xlab('FG Attempt') + 
  title_with_subtitle('Player Scoring Performance 2015-2016 NBA', 'as of 01/03/2016') +
  theme_tws(base_size = 15) + 
  theme(legend.position = 'none')

value.plot.1415 <<- ggplot() + 
  geom_point(aes(x = value.1415$FGA, y = value.1415$PtsDiff, color = factor(sign(value.1415$PtsDiff))), size = 4, shape = 1) + 
  scale_colour_manual(values=c("#D55E00", "#009E73"))+
  #geom_text(aes(show$FGA, show$FGMDiff), label = show$name, size = 4,hjust=0.5, vjust=-0.6)+
  #geom_point(aes(show$FGA, show$FGMDiff), size = 4)+
  ylab('Value Added by Points Scored') + xlab('FG Attempt') + 
  title_with_subtitle('Player Scoring Performance 2014-2015 NBA', 'Regular Season') +
  theme_tws(base_size = 15) + 
  theme(legend.position = 'none')

shotSel.dist.1415 <- aggregate(totalFGA ~ ShotDist, league.1415, sum)[c(1, 8, 2:7),]
shotSel.dist.1415 <<- mutate(shotSel.dist.1415, perc = totalFGA/sum(totalFGA), y.breaks = cumsum(perc) - perc/2)


shotSel.def.1415 <- aggregate(totalFGA ~ DefDist, league.1415, sum)
shotSel.def.1415 <<- mutate(shotSel.def.1415, perc = totalFGA/sum(totalFGA), y.breaks = cumsum(perc) - perc/2)

shotSel.dist.1516 <- aggregate(totalFGA ~ ShotDist, league.1516, sum)[c(1, 8, 2:7),]
shotSel.dist.1516 <<- mutate(shotSel.dist.1516, perc = totalFGA/sum(totalFGA), y.breaks = cumsum(perc) - perc/2)


shotSel.def.1516 <- aggregate(totalFGA ~ DefDist, league.1516, sum)
shotSel.def.1516 <<- mutate(shotSel.def.1516, perc = totalFGA/sum(totalFGA), y.breaks = cumsum(perc) - perc/2)


