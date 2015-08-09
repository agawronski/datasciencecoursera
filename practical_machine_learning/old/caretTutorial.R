#http://www.edii.uclm.es/~useR-2013/Tutorials/kuhn/user_caret_2up.pdf
library(caret)
data(segmentationData)
segmentationData$Cell <- NULL

training <- subset(segmentationData, Case=="Train")
testing <- subset(segmentationData, Case=="Test")
training$Case <- NULL
testing$Case <- NULL
str(training[,1:6])
