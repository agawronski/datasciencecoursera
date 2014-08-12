rm(list=ls())
getwd()
setwd("C:/Users/NC/data_science")

complete <- function(directory, id = 1:332){
  files<-list.files("specdata", full.names=TRUE)
  all_data<-data.frame() #empty frame
  for (i in id) {
    all_data<-rbind(all_data, read.csv(files[i])) #add all data for given id
  }
  final_table<-data.frame() #empty
  for (i in id){
    final_table<-rbind(c(i,sum(complete.cases(all_data[all_data$ID==i,]))))
  }
  colnames(final_table)<-c("id","nobs")
  print(final_table)
  class(final_table)
}
  

