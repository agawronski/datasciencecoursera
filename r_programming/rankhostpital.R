## Rank hospitals by outcome in a state

## write a function called "rankhospital"
 
## state (eg. "NY"), outcome (eg. "pnemonia"), num (eg. "2")
## rankhospital reads "outcome-of-care-measures.csv"...
## returns a character vector with the hospital specified by num
## with the lowest 30 day mort for the specified outcome
## num can accept "best" "worst" or an integer
## num > hospitals in state returns NA
## ties settled by alphabetical hospital name

rankhospital <- function(state, outcome, num="best"){
  
  ##Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  data <- data[,c(2,7,11,17,23)]
  data[,c(3,4,5)] <- sapply(data[,c(3,4,5)], as.numeric)
  names(data) <- c("hospitals","states","heart attack","heart failure","pneumonia")
  
  ##check that state and outcome are valid
  states <- data[,2]
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if(!(state%in%states)){stop("invalid state")}
  if(!(outcome%in%outcomes)) {stop("invalid outcome")}
  
  #best and worst
  if (num == "best") {num <- 1}
  if (num == "worst") {num <- length(data[states==state,2])}
  if (num > length(data[states==state,2])) {num <- return(NA)}
  
  #order by alphabet
  data <- data[order(data[,1]),]
  
  ##return hospital name in that state with the given rank
  ##30-day mort rate
  if(outcome=="heart attack"){
    odata <- data[order(data[,3]),]
    sodata <- odata[odata[,2]==state,c(1,3)]
    n <- nrow(sodata)
    rank <- cbind(sodata,1:n)
    match <- rank[rank[,3]==num,1]
  }
  else if (outcome=="heart failure") {
    odata <- data[order(data[,4]),]
    sodata <- odata[odata[,2]==state,c(1,3)]
    n <- nrow(sodata)
    rank <- cbind(sodata,1:n)
    match <- rank[rank[,3]==num,1]
  }
  else {
    odata <- data[order(data[,5]),]
    sodata <- odata[odata[,2]==state,c(1,3)]
    n <- nrow(sodata)
    rank <- cbind(sodata,1:n)
    match <- rank[rank[,3]==num,1]
  }
  match
}
