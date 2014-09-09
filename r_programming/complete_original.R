rm(list=ls())
getwd()
setwd("C:/Users/NC/data_science")

id<-30:25
complete <- function(directory, id = 1:332){
  files<-list.files("specdata", full.names=TRUE) #character vec of filenames in specdata
  all_data<-data.frame() #empty frame
  for (i in id) {
    all_data<-rbind(all_data, read.csv(files[i])) #add all data for given id
  }
  cc<-all_data[complete.cases(all_data),] #subset all complete cases
  cc_vec<-cc[,"ID"] #remove only the character vector of id numbers
  almost<-as.data.frame(table(cc_vec)) #tabulate and coerce to a df
  colnames(almost)<-c("id","nobs") #change names
  names(almost)
  print(almost)
}

