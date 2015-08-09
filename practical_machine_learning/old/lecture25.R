library(caret)
library(kernlab)
data(spam)
#inTrain <- createDataPartition(spam$type, p=0.75, list=FALSE)
#training <- spam[inTrain,]
#testing <- spam[-inTrain,]
set.seed(32323)
folds <- createFolds(y=spam$type, k=10, list=TRUE, returnTrain=FALSE)
sapply(folds, length)
folds[[1]][1:10]

#Resampling or Bootstrapping
fold <- createResample(y=spam$type, times=10, list=TRUE)
sapply(fold, length)
fold[[1]][1:10]

#Time series
tme <- 1:1000
foldtime <- createTimeSlices(y=tme, initialWindow=20, horizon=10)
names(foldtime)
foldtime$train
foldtime$train[[1]]
foldtime$test[[1]]
