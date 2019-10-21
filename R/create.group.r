create.group = function(mean = 20, sd = 10){
  
  # mean = 20
  # sd = 5
  
  # introduce a new neighbouring group of a size around 20 but with SD
  group.size = sample.with.lims(1, mean = mean, sd = sd, lims = c(min.group.size,38),round = 0, method = "normal")
  
  df = data.frame (
  # Strength of each individual in the focal group
  strengths = sample.with.lims (group.size,  mean = 0.05, sd = 0.025, lims = c(0.01,0.09), round = 20, method = "uniform"),
  
  # fitness
  fitness = rep(1,group.size),
  
  # altruism
  altruism = sample.with.lims (group.size,  mean = 0.5, sd = 0.25, lims = c(0,1), round = 20, method = "uniform"),
  
  # generation
  generation = 1
  )
  

  return( df)

}
