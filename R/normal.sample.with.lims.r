sample.with.lims = function ( x, mean = 0.5, sd= 0.25, lims=  c( 0.1,0.9), round = 1, method = c("normal" , "uniform")){
  # x = 10
  # mean = 0.05
  # sd = 0.025
  # lims = c(0.1, 0.9)
  # round = 1
  
  if ( method == "normal"){
  ro = round( rnorm( x, mean, sd),round)
  ro = ifelse ( ro > lims[2], lims[2], ro)
  ro = ifelse ( ro < lims[1], lims[1], ro)
  } 
  if ( method == "uniform"){
    ro = round ( runif(x, lims[1], lims[2]), round)
  }
  return(ro)
}
