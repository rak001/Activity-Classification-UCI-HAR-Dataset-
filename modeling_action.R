
## model for action prediction

if(dir.exists("cluster_action/")==FALSE)
{  dir.create("cluster_action") }


rm(list=ls())
setwd("C:/Users/Rahul/Desktop/R_programming_coursea/HADCO/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/")
setwd("train/")

subject_train<-read.csv("subject_train.txt",header = FALSE)
trainee<-read.csv("y_train.txt",header = FALSE)
featureData<-read.table("X_train.txt")

library(dplyr)

featureData<-dplyr::tbl_df(featureData)
nx<-dim(featureData)
names(featureData)<-paste("feature",1:nx[2])
names(subject_train)<-"subject"
names(trainee)<-"trainee"

data_x<-data.frame(subject_train,trainee,featureData)

## number of subject
n<-unique(data_x[,2])
clust.kcluster<-1
clust.itermax<-100
clust.center<-{}
for(i in n)
{
  train_class<-data_x[data_x$trainee==i,3:(nx[2]+2)]
  #nt<-dim(train_class)
  #train_class<-data.matrix(train_class,dim(train_class))
  k_meansclustering<-kmeans(train_class,clust.kcluster,clust.itermax,1L)
  clust.center<-rbind(clust.center,k_meansclustering$centers)
}


save(clust.kcluster, clust.center,n, file = paste("../cluster_action/cluster_",clust.kcluster,".RData"))


setwd("../test/")
rm(list=ls())

subject_test<-read.csv("subject_test.txt",header = FALSE)
trainee<-read.csv("y_test.txt",header = FALSE)
featureData<-read.table("X_test.txt")

library(dplyr)
clust.kcluster<-3
featureData<-dplyr::tbl_df(featureData)
nx<-dim(featureData)
names(featureData)<-paste("feature",1:nx[2])
names(subject_test)<-"subject"
names(trainee)<-"trainee"

data_x<-data.frame(subject_test,trainee,featureData)
load(file = paste("../cluster_action/cluster_",clust.kcluster,".RData"))

conf_matrix<-matrix(seq(0,1,length=length(n)^2)*0,length(n),length(n))
#source('C:/Users/Rahul/Desktop/R_programming_coursea/HADCO/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/rowRepeat.R')
nclust<-dim(clust.center)[1]

for(i in n)
{
  test_class<-data_x[data_x$trainee==i,3:(nx[2]+2)]
  nt<-dim(test_class)
  for(j in c(1:nt[1]))
  {
   
    tx<-test_class[j,]
    m<-{}
    for (k in c(1:(length(n)*clust.kcluster)))
    {
      m<-c(m,sum((tx-clust.center[k,])^2))
      
    }
  conf_matrix[i,n[ceiling(which.min(m)/clust.kcluster)]]=conf_matrix[i,n[ceiling(which.min(m)/clust.kcluster)]]+1;
    
}
   
}

conf_matrix

acc<-sum(diag(conf_matrix))/sum(conf_matrix)*100
acc
file_name<-paste("../cluster_action/cluster_test",clust.kcluster,".RData")
save(clust.kcluster, clust.center,n,conf_matrix,acc, file = file_name)