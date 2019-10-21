indiv.decision = function ( battle.group1 , battle.group2){
  
  # battle.group1 = battle.groups[[2]]
  # battle.group2 = battle.groups[[1]]
  
  # participate or not?
  participate1 = rep(NA, nrow(battle.group1)) # this empty vector will be filled in the loop below
  
  for ( i in 1:nrow(battle.group1)){
    # i=1
    
    # assume that prop.defected amount will defect. multiply by the group's mean strength (which a focal individual guesses to be 0.5), add my strength or not
    our.strength.without.me = prop.defect*0.5*(nrow(battle.group1)-1) 
    our.strength.with.me    = our.strength.without.me + battle.group1$strengths[i]
    
    # distribution of neighbour attacking power
    dist =  colSums ( replicate( 1000, rbinom (nrow(battle.group2),1,prop.defect) *0.5))
    
    #probability of winning if I participate? 
    p.part = 1-(length( which( dist > our.strength.with.me))/1000)
    
    #probability of winning if I don't?
    p.nopart = 1-(length( which( dist > our.strength.without.me))/1000)
    
    # ultimate cost of participating
    u.part = ((p.part * benefit.of.winning) -(battle.group1$strengths[i]*cost.of.participating.mult))  - # benefit of participating. (Chance of winning * winning benefit) minus cost of participation
      ((1-p.part)*cost.of.losing) # minus the costs of losing (losing cost * probability)
    
    # ultimate cost of not participating
    u.nopart = (p.nopart * benefit.of.winning) - ((1-p.nopart)*cost.of.losing)
    
    # participate?
    participate1[i] = ifelse( u.part> u.nopart, 1 ,rbinom(1,1,battle.group1$altruism[i]))
  }
  participate1.log = as.logical(participate1)
  
  #consensus?
  consensus = ifelse ( sum(participate1) >= nrow(battle.group1)*consensus.lim,
                       1, 0)
  
  # Total strength of focal group
  sum.strength = sum( battle.group1$strengths[participate1.log] )
  
  # cost of participating if your group wins
  cost.if.win = ( battle.group1$strengths*cost.of.participating.mult)*participate1
  
  # return items
  return( list ( consensus = consensus,
                 sum.strength = sum.strength, 
                 cost.if.win = cost.if.win))
  
}
