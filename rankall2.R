
rankall <- function (outcome, num = "best") {
  
  #load the data
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  data <- data[,c(2,7,11,17,23)]
  data[,c(3,4,5)] <- suppressWarnings(sapply(data[,c(3,4,5)], as.numeric))
  names(data) <- c("hospitals","states","heart attack","heart failure","pneumonia")
  
  #check that outcome is valid
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if(!(outcome%in%outcomes)) {stop("invalid outcome")}
  
  #clean
  d <- data[[outcome]]
  main <- cbind(data[,c(1,2)],d)
  
  #split main data frame by state
  state_list <- split(main, main$states, drop=FALSE)
  
  
  if(num=="best") {
    best <- lapply(state_list, function(x) x[order(x[,"d"]),]) #ordering ascending
    final_list <- lapply(best, "[", 1,c(1,2),drop=TRUE) #make a df with the first entry on each list
  }
  else if(num=="worst") {
    worst <- lapply(state_list, function(x) x[order(x[,"d"],decreasing=TRUE),]) #order descending
    final_list <- lapply(worst, "[", 1,c(1,2),drop=TRUE) #make a df with the first entry on each list
  }
  else if(is.numeric(num)) {
    order <- lapply(state_list, function(x) x[order(x[,"d"]),]) #ordering ascending
    final_list <- lapply(order, "[", num,c(1,2),drop=TRUE) #make a df with entry = num
  }
  else {
    stop("invalid num")
  }
  final_df <- as.data.frame(do.call("rbind", final_list))
  final_df
  
}
