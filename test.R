rm(list=ls())
getwd()
setwd("C:/Users/NC/data_science/datasciencecoursera")

pollutantmean<-function(directory, pollutant, id=1:332){
  if(pollutant=="nitrate"){
    all_files<-list.files("specdata", full.names=TRUE)
    data<-data.frame()
    for (i in id){
      data<-rbind(data, read.csv(all_files[i]),colClasses=c("Null","Null",NA,NA))
    }
  else if (pollutant=="sulfate"){
    all_files<-list.files("specdata", full.names=TRUE)
    data<-data.frame()
    for (i in id){
      data<-rbind(data, read.csv(all_files[i]),colClasses=c("Null",NA,"Null",NA))
  }  
  }
}