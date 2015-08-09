library(caret)
library(kernlab)
data(spam)

inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]

M <- abs(cor(training[,-58]))
#every variable is perfectly correlated with itself, so set those to zero
diag(M) <- 0
# which of these variables have a high correlation with each other?
which(M>0.8, arr.ind=T)

#take a look at the first two of these
names(spam)[c(34,32)]
plot(spam[,34],spam[,32])

#We might not need every predictor, a weighted comnination of 
# predictors might be better
# PCA alsot reduces noise

# We could rotate the plot
X <- 0.71*training$num415 + 0.71*training$num857
Y <- 0.71*