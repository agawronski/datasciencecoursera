rm(list=ls())
getwd()
setwd("C:/Users/NC/data_science/datasciencecoursera")
list.files("specdata")
check<-read.csv("specdata/001.csv")
head(check)
check2<-read.csv("specdata/002.csv")
head(check2)
length(check$ID)
all_files<-list.files("specdata", full.names=TRUE)
all_files
data<-data.frame()
for (i in 1:33){
  data<-rbind(data, read.csv(all_files[i]))
}
head(data)
mean(data$sulfate, na.rm=TRUE)

pollutantmean<-function(directory, pollutant, id=1:33){
  all_files<-list.files("specdata", full.names=TRUE)
  data<-data.frame()
  for (i in 1:33){
      data<-rbind(data, read.csv(all_files[i]))
  }
  monitor<-data[data$ID==id,]
}