
corr <- function(directory, threshold = 0) {
  files<-list.files("specdata",full.names=TRUE)
  n<-length(files)
  all_data<-data.frame() # all data "Date", "sulfate", "nitrate", "ID"
  for (i in 1:n){
    all_data<-rbind(all_data, read.csv(files[i]))
  }
  complete<-data.frame() #will contain number of complete cases per monitor
  for (j in 1:n){
    complete<-rbind(complete, c(j,sum(complete.cases(all_data[all_data$ID==j,]))))
  }
  colnames(complete)<-c("monitor","cases") # complete has "monitor" and "cases"
  greater<-complete[complete$cases>threshold,] # subset of complete with monitors above threshold
  clean_data<-all_data[complete.cases(all_data)==TRUE,] # clean all_data 
  cor_vec<-data.frame()
  for (k in greater$monitor){
    cor_vec<-rbind(cor_vec, cor(subset(clean_data$sulfate,clean_data$ID==k),subset(clean_data$nitrate,clean_data$ID==k)))
  }
  final<-as.vector(as.matrix(cor_vec))
  print(final)
}
