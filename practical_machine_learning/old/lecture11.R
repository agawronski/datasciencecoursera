library(kernlab); data(spam); set.seed(333)
smallSpam <- spam[sample(dim(spam)[1], size=10),]
spamLabel <- (smallSpam$type=="spam")*1 + 1
plot(smallSpam$capitalAve, col=spamLabel)

#Out of sample error is always larger than in-sample error

rule1 <- function(x){
  prediction <- rep(NA, length(x))
  prediction[x>2.7] <- "spam"
  prediction[x<2.4] <- "nonspam"
  prediction[x>=2.4 & x<=2.7] <- "spam"
  prediction[x>2.45 & x<=2.7] <- "nonspam"
  return(prediction)
}
table(rule1(smallSpam$capitalAve), smallSpam$type)

rule2 <- function(x) {
  prediction <- rep(NA, length(x))
  prediction[smallSpam$capitalAve>2.8] <- "spam"
  prediction[smallSpam$capitalAve<=2.8] <- "nonspam"
  return(prediction)
}
table(rule2(smallSpam$capitalAve), smallSpam$type)

#Lets see on whole dataset
table(rule1(spam$capitalAve), spam$type)
table(rule2(spam$capitalAve), spam$type)

#Check accuracy by seeing if our predictions equal the actual spam type
sum(rule1(spam$capitalAve)==spam$type)
sum(rule2(spam$capitalAve)==spam$type)