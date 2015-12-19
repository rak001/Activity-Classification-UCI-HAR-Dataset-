action_test<-function(inputdata,model_path)
{
  
  load(file = model_path)
  m<-{}
  for (k in c(1:(length(n)*clust.kcluster)))
  {
    m<-c(m,sum((inputdata-clust.center[k,])^2))
    
  }
  class<-n[ceiling(which.min(m)/clust.kcluster)]
  class
}