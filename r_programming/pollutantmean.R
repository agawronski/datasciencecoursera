
pollutantmean<-function(directory, pollutant, id=1:332) { 
  all_files<-list.files("specdata", full.names=TRUE) #character vec of filenames
  data<-data.frame() #empty frame
  for (i in id){
      data<-rbind(data, read.csv(all_files[i]))
  }
  if(pollutant=="sulfate") {
    p_data<-data[,c("sulfate","ID")]
  }
  else if(pollutant=="nitrate"){
    p_data<-data[,c("nitrate","ID")]
  }
  else(print("Which pollutant?")) 
  mean(p_data[,1], na.rm=TRUE)
}