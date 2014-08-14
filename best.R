##outcome<-read.csv("outcome-of-care-measures.csv",colClasses="character")
##head(outcome)
##colnames(outcome)
##dim(outcome)
##outcome[,11]<-as.numeric(outcome[,11])
##hist(outcome[,11])
##outcome$Hospital.Name # names of the hospitals
##outcome$State # abbreviated states

best<-function(state,outcome) {
  all_data<-read.csv("outcome-of-care-measures.csv",colClasses="character")
  if(state %in% all_data$State) {
    three<-c("heart attack","heart failure", "pneumonia")
    if(outcome %in% three) {
      state_data<-all_data[which(all_data$State==state),c(2,11,17,23)]
      names(state_data)<-c("h_name","heart attack","heart failure","pneumonia")
    }
    else stop("invalid outcome")
  }
  else stop("invalid state")
  state_data[,c(2,3,4)]<-sapply(state_data[,c(2,3,4)], as.numeric)
  state_data<-state_data[order(state_data[,1]),] # alphabetize
  if (outcome=="heart attack") {
    final_set<-state_data[,c("h_name","heart attack")]
  }
  else if (outcome=="heart failure") {
    final_set<-state_data[,c("h_name","heart failure")]
  }
  else {
    final_set<-state_data[,c("h_name","pneumonia")]
  }
  besth<-final_set[which.min(final_set[,2]),1]
  print(besth)
}

