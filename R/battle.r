battle = function ( battle1, battle2){
  
  if ( battle1$consensus == 0 && battle2$consensus == 0){
    battle.cost.ben1 = 0
    battle.cost.ben2 = 0
  }
  if ( battle1$consensus == 1 && battle2$consensus == 0){
    battle.cost.ben1 = benefit.of.winning
    battle.cost.ben2 = -cost.of.losing
  }
  if ( battle1$consensus == 0 && battle2$consensus == 1){
    battle.cost.ben1 = -cost.of.losing
    battle.cost.ben2 = benefit.of.winning
  }
  if ( battle1$consensus == 1 && battle2$consensus == 1){
    
    if( battle1$sum.strength >= battle2$sum.strength ){ # one team randomly wins, and this is decided by the randomly selected group
      battle.cost.ben1 =  rep(benefit.of.winning, length(battle1$cost.if.win))- battle1$cost.if.win
      battle.cost.ben2 = -rep(cost.of.losing    , length(battle2$cost.if.win))
    } else {
      battle.cost.ben2 =  rep(benefit.of.winning, length(battle2$cost.if.win))- battle2$cost.if.win
      battle.cost.ben1 = -rep(cost.of.losing    , length(battle1$cost.if.win))
    }
  }
  
  return( list ( battle.cost.ben1 = battle.cost.ben1, 
                 battle.cost.ben2 = battle.cost.ben2))
}