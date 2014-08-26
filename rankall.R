
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
    best <- lapply(state_list, function(x) x[order(x[,"d"], x[,"hospitals"]),]) #ordering ascending
    final_list <- lapply(best, "[", 1, 1, drop=TRUE) #make a df with the first entry on each list
    final_states   <- lapply(best, "[", 1, 2, drop=TRUE)
  }
  else if(num=="worst") {
    worst <- lapply(state_list, function(x) x[order(x[,"d"], -rank(x[,"hospitals"]), decreasing=TRUE),]) #order descending
    final_list <- lapply(worst, "[", 1,1,drop=TRUE) #make a df with the first entry on each list
    final_states <- lapply(worst, "[", 1, 2, drop=TRUE)
  }
  else if(is.numeric(num)) {
    order <- lapply(state_list, function(x) x[order(x[,"d"], x[,"hospitals"]),]) #ordering ascending
    final_list <- lapply(order, "[", num,1,drop=TRUE) #make a df with entry = num
    final_states <- lapply(order, "[", 1, 2, drop=TRUE)
  }
  else {
    stop("invalid num")
  }
  hospital_vec <- as.data.frame(do.call("rbind", final_list))
  state_vec <- as.data.frame(do.call("rbind", final_states))
  final_df <- cbind(hospital_vec, state_vec)
  names(final_df) <- c("hospital", "state")
  final_df
  
}
