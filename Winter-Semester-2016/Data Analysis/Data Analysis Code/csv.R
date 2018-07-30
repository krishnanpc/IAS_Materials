args = commandArgs(trailingOnly = TRUE)

computeMeanCSV =  function(args){

  y = read.csv(file = args[1], TRUE, ",")
  
  return(mean(y[[args[2]]], na.rm = TRUE))
  
}

 print(start.time <- Sys.time())
 computeMeanCSV(args)
 print(end.time <- Sys.time())
 time.taken <- end.time - start.time
 print(time.taken)

 # call it from command line  Rscript 3-csv.R pitbull-ddw1024k.csv DeltaTime

# sayHello <- function(args){
# 
#   print(args[1])
#   print(args[2])
# }
# sayHello(args)