time.squeeze = function(){
  t1 = gsub( " " , "_", Sys.time())
  t2 = gsub( ":" , "-", t1)
  return(t2)
}
