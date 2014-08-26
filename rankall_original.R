

rankall <- function (outcome, num = "best") {

  #read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  data <- data[,c(2,7,11,17,23)]
  data[,c(3,4,5)] <- sapply(data[,c(3,4,5)], as.numeric)
  names(data) <- c("hospitals","states","heart attack","heart failure","pneumonia")
  
  #check that state and outcome are vaild
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if(!(outcome%in%outcomes)) {stop("invalid outcome")}
  
  div <- split(data, data$states, drop=FALSE)
  org <- lapply(div, function(x) x[order(x[,outcome]),])
  final_list <- lapply(org, "[", 20,c(1,2,3,4),drop=TRUE)
  final_df <- do.call("rbind", final_list)
  final_df
}