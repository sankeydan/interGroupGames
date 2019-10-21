build.heat = function (xvar = NULL, yvar = NULL, yLab = "", xLab = "", uber_smoothness = 100){
  
  # xvar = rb$strengths
  # yvar = rb$altruism
  # uber_smoothness = 100
  
  df = data.frame(x = xvar , y = yvar)
  

  return( ggplot(df, aes(x, y))  +
            stat_density2d(geom="tile",aes(fill=..density..), contour=FALSE, n= uber_smoothness)  +
            scale_fill_gradientn(colours = rev(rainbow(10)[1:7]), trans="sqrt")+
    theme(text=element_text(size=16,  family="serif"))+
    ylab(yLab)+
    xlab(xLab)
  )
  

  
}
