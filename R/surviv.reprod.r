surviv.reprod = function ( groups){
  for ( i in 1:num.groups){
    #i=1
    
    # population size
    pop.size = length(unlist(groups))/4
    
    # extract data
    df = groups[[i]]
    
    # survival
    df$fitness = round (df$fitness,1)
    df$fitness = ifelse ( df$fitness  <min.fitness, min.fitness, df$fitness)
    df$fitness = ifelse ( df$fitness  >max.fitness, max.fitness, df$fitness)
    val = 1/ (1+(  ( 1 +  (1/df$fitness)) - max.fitness) )
    survivors = as.logical ( rbinom( nrow(df), 1, val))
    df = df[survivors,]
    
    # reproduction
    val = 1/ 
      (
          (1+(  ( 1 +  (1/df$fitness)) - max.fitness) ) +
          (nrow(df)^group.size.penalty *group.size.const) + 
          (1/pop.size) 
      )
    reproducers = as.logical ( rbinom( nrow(df), 1, val ))
    if( length( which ( reproducers)) > 0){
      new.pups = df[reproducers,]
      new.pups$strengths = sample.with.lims(nrow(new.pups),mean = new.pups$strengths, sd = new.gen.strength.sd,lims = c(0.01,0.09), round = 20, method = "normal")
      new.pups$altruism  = sample.with.lims(nrow(new.pups),mean = new.pups$altruism , sd = new.gen.altruism.sd,lims = c(0.1 ,0.9 ), round = 20, method = "normal")
      new.pups$fitness = 1
      new.pups$generation = new.pups$generation + 1
      
      # combine
      df = rbind( df, new.pups)
    }
    rownames(df) = NULL
    groups[[i]] = df
    
  }
  return( groups)
}