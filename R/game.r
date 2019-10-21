### INTER GROUP GAMES ###

game = function ( n.iter = 100, 
                  n.repeats = 100, 
                  cost.of.losing = 0.05,
                  benefit.of.winning = 0.1,
                  cost.of.participating.mult = 0.7, # strength of focal individual * x . Assumption - stronger individuals will commit more. To relax this assumption, change parameter to 1 
                  consensus.lim = 0.25 ,
                  num.groups = 3,
                  prop.defect = 0.5, # proportion of individuals that cheated on the round before the first iteration. 
                  #This does nothing in the first version of the model, but can be updated each round to remember. 
                  # i.e. iterative prisoners dillemma games
                  min.fitness = 0.4,
                  max.fitness = 1.6,
                  new.gen.strength.sd = 0.01, # new generation have same traits as their parents, but with some variance
                  new.gen.altruism.sd = 0.1,
                  min.group.size = 3, # group goes extinct when it has fewer than this many members
                  group.size.penalty = 3,
                  group.size.const = 0.001)
{
  
  
  # objects 
  
  # {
  # n.iter = 100
  # n.repeats = 100
  # cost.of.losing = 0.05
  # benefit.of.winning = 0.1
  # cost.of.participating.mult = 0.7 # strength of focal individual * x . Assumption - stronger individuals will commit more. To relax this assumption, change parameter to 1
  # consensus.lim = 0.25 # need this proportion of group members to agree to engage in conflict.
  # num.groups = 3
  # prop.defect = 0.5 # proportion of individuals that cheated on the round before the first iteration.
  # #This does nothing in the first version of the model, but can be updated each round to remember.
  # # i.e. iterative prisoners dillemma games
  # min.fitness = 0.4
  # max.fitness = 1.6
  # aging = 0.0 # reduce fitness by aging param each turn
  # new.gen.strength.sd = 0.01 # new generation have same traits as their parents, but with some variance
  # new.gen.altruism.sd = 0.1
  # min.group.size = 3 # group goes extinct when it has fewer than this many members
  # group.size.penalty = 3
  # group.size.const = 0.001
  # }
  
  # Variables
  variables = cbind ( ls(), apply ( t(ls()), 2, function ( x) { get(x)}) )
  print (variables)
  
  # Empty objects
  groups.list = list() # save the data after each battle (n.iter)
  group.data = list() # save the data after each series of battles (n.repeat)
  group.remove = list() # which groups have gone extinct? 
  
  
  #loop
  for ( k in 1:n.repeats){
    
    ########### CREATE GROUPS ########
    groups = list()
    for ( i in 1:num.groups){
      groups[[i]] = create.group(mean = 20, sd = 5)
    }
    
    ######## INTERGROUP CONFLICT LOOP #########
    
    m = 1 # use this as a handy tool to fill the group.remove list above
    for ( i in 1:n.iter){
      
      # randomly sample 2 groups to compete
      participating.groups = sample ( 1:num.groups,2)
      battle.groups = list ( groups[[participating.groups[1]]],
                             groups[[participating.groups[2]]])
      
      #### Individual Decisions ###
      
      ## Each focal individual makes informed decisions based on their strength, 
      # and the estimated combined strength of focal group and neighbour group
      battle1 = indiv.decision ( battle.groups[[1]], battle.groups[[2]] )
      battle2 = indiv.decision ( battle.groups[[2]], battle.groups[[1]] )
      
      #### Battle ###
      bat.cost.ben = battle( battle1, battle2)
      
      ##### Update fitness #### 
      groups[[ participating.groups[1] ]]$fitness = groups[[ participating.groups[1] ]]$fitness+bat.cost.ben$battle.cost.ben1
      groups[[ participating.groups[2] ]]$fitness = groups[[ participating.groups[2] ]]$fitness+bat.cost.ben$battle.cost.ben2
      
      ##### Reproduction / survival #####
      groups = surviv.reprod( groups) #All groups, regardless of whether battle or not.
      
      ##### Save groups to list and replace small groups #####
      groups.list[[i]] = groups
    
      ### remove and replace small (extinct) groups
      vec= vector()
      for ( j in 1:num.groups){
        vec = c(vec,  nrow( groups[[j]]))
        if( nrow( groups[[j]]) <= min.group.size){
          group.remove[[m]] = list ( group = groups[[j]],iter.num = i, group.num = j)
          m = m+1
          groups[[j]] = create.group(mean = 20, sd=5)
        }
      }
      print(vec)
    }
    
    ###### Add to bigdata #### 
    group.data[[k]]  = list( groups.list =  groups.list, 
                             group.remove=  group.remove)
    # Take stock
    print( paste( k, "/" , n.repeats))
  }
  
  # SAVE
  all.data = list ( group.data = group.data, variables = variables)
  file.name = paste0( "interGroupGame_", time.squeeze(), ".rda" )
  
  save( all.data , file = file.path (PROJHOME, "Output", file.name))  
}