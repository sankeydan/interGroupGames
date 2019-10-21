# 01_set up and run intergroup games

# housekeeping 
rm( list = ls())

# Functions
library( interGroupGames) # if this doesn't work, run script below.
fold= file.path ( PROJHOME , "R")
files = list.files( fold)
for ( i in 1:length(files)){
  source( file.path ( fold, files[i]))
}

# objects
{
n.iter = 100
n.repeats = 50
cost.of.losing = 0.05 # classic prisoners dillemma value
benefit.of.winning = 0.1 # as above
cost.of.participating.mult = 0.6 # strength of focal individual * x . Assumption stronger individuals commit more, i.e. live fast die young hypothesis
consensus.lim = 0.25 # need this proportion of group members to agree to engage in conflict.
num.groups = 3 # how many groups in the population. Will include eviction dynamics instead in future models
prop.defect = 0.5 # proportion of individuals that cheated on the round before the first iteration.
#This does nothing in the first version of the model, but can be updated each round to remember.
# i.e. iterative prisoners dillemma games
max.fitness = 1.6 # for now, need to put a cap on max and min fitness
min.fitness = 0.4
new.gen.strength.sd = 0.01 # new generation have same traits as their parents, but with some variance
new.gen.altruism.sd = 0.1 # as above
min.group.size = 3 # group goes extinct when it has fewer than this many members
group.size.penalty = 3 # When group size is too large, successful reproduction is less likely
group.size.const = 0.001 # reproduction probabilities are too low without this constant.
}

# game
game(n.iter = n.iter,n.repeats = n.repeats,cost.of.losing = cost.of.losing,benefit.of.winning = benefit.of.winning,
     cost.of.participating.mult = cost.of.participating.mult,consensus.lim = consensus.lim,num.groups = num.groups,
     prop.defect = prop.defect, min.fitness = min.fitness,max.fitness = max.fitness,new.gen.strength.sd = new.gen.strength.sd,
     new.gen.altruism.sd = new.gen.altruism.sd,min.group.size = min.group.size,group.size.penalty = group.size.penalty,
     group.size.const = group.size.const)

# This will save the data and the variables to a list in the "Output" folder

## Now move run with different variables or move to script 02_analysis

