## 02_Analysis

# Housekeeping
rm(list = ls())

# Functions
library( interGroupGames) # if this doesn't work, run script below.
fold= file.path ( PROJHOME , "R")
files = list.files( fold)
for ( i in 1:length(files)){
  source( file.path ( fold, files[i]))
}

### DATA
fold = file.path ( PROJHOME , "Output"  )
files = list.files( fold)
colnames = c( "strengths",  "fitness" ,   "altruism"   ,"generation")
rb = matrix( NA, 0, length(colnames), dimnames = list( NULL, colnames))

### LOOP FILES (not yet)

#for ( i in 1:length(files)){
i=2

# data
load( file.path(fold, files[i]))
variables = all.data[[2]]
data.list = all.data[[1]]

##### LOOP ITERATIONS

for ( j in 1:length(data.list)){
  #j=1
  groups = data.list[[j]][[1]][[as.numeric( variables[which(variables[,1] == "n.iter"),2])]]
  g1 = groups[[1]]
  g2 = groups[[2]]
  g3 = groups[[3]]
  rb = rbind( rb, rbind( g1,g2,g3))
}

#}

### PLOT
rb$strengths[rb$strengths>0.09] = NA
rb$strengths[rb$strengths<0.01] = NA
rb$altruism[rb$altruism>0.9] = NA
rb$altruism[rb$altruism<0.1] = NA
rb2 = rb[rb$generation>25,] # only animals born after 25 generations
g1 = build.heat(rb$strengths ,  rb$altruism, yLab = "Altruism" , xLab = "Strength")
g2 = build.heat(rb2$strengths, rb2$altruism, yLab = "Altruism" , xLab = "Strength")
library(gridExtra)
gridExtra::grid.arrange(g1,g2, nrow = 2)
plot.gri