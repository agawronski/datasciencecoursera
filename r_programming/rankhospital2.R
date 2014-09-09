## Rank hospitals by outcome in a state

## write a function called "rankhospital"

## state (eg. "NY"), outcome (eg. "pneumonia"), num (eg. "2")
## rankhospital reads "outcome-of-care-measures.csv"...
## returns a character vector with the hospital specified by num
## with the lowest 30 day mort for the specified outcome
## num can accept "best" "worst" or an integer
## num > hospitals in state returns NA
## ties settled by alphabetical hospital name

rankhospital <- function(state, outcome, num="best") {

  #read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  data <- data[,c(2,7,11,17,23)]
  data[,c(3,4,5)] <- sapply(data[,c(3,4,5)], as.numeric)
  names(data) <- c("hospitals","states","heart attack","heart failure","pneumonia")

  #check that state and outcome are vaild
  states <- data[,2]
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if(!(state%in%states)){stop("invalid state")}
  if(!(outcome%in%outcomes)) {stop("invalid outcome")}
  
  #best and worst
  if (num == "best") {num <- 1}
  if (num == "worst") {num <- length(na.omit(data[data$states==state & data[,outcome]!="NA", outcome]))}
  if (num > length(na.omit(data[data$states==state & data[,outcome]!="NA", outcome]))) {num <- return(NA)}
  
  #return first ordered value
  if (outcome=="heart attack") {
    sort <- data[order(data[,3], data[,1]), c(1,2,3)]
    slice <- sort[sort[,2]==state,1]
  }
  else if (outcome=="heart failure") {
    sort <- data[order(data[,4], data[,1]), c(1,2,4)]
    slice <- sort[sort[,2]==state,1]
  }
  else {
    sort <- data[order(data[,5], data[,1]), c(1,2,5)]
    slice <- sort[sort[,2]==state,]
  }
  slice[num]
}