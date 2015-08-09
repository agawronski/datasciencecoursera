library(caret);library(kernlab);data(spam)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
hist(training$capitalAve, main="", xlab="ave. capital run length")

mean(training$capitalAve)
sd(training$capitalAve)
str(training$capitalAve)
sum(!complete.cases(training$capitalAve))

trainCapAve <- training$capitalAve
trainCapAveS <- (trainCapAve - mean(trainCapAve))/sd(trainCapAve)
trainCapAveS
mean(trainCapAveS)
sd(trainCapAveS)

#must use mean and sd from TRAINING to alter TEST set
testCapAve <- testing$capitalAve
testCapAveS <- (testCapAve - mean(trainCapAve))/sd(trainCapAve)
mean(testCapAveS)
sd(testCapAveS)

#using preProcess
preObj <- preProcess(training[,-58], method=c("center", "scale"))
trainCapAveS <- predict(preObj, training[,-58])$capitalAve
mean(trainCapAveS)

#using preProcess on the test set
testCapAveS <- predict(preObj, testing[,-58])$capitalAve

set.seed(32343)
modelFit <- train(type~., data=training, preProcess=c("center", "scale"), method="glm")
modelFit

#standardizing with Box-Cox
preObj <- preProcess(training[,-58],method=c("BoxCox"))
trainCapAveS <- predict(preObj, training[,-58])$capitalAve
par(mfrow=c(1,2))
hist(trainCapAveS)
qqnorm(trainCapAveS)

#previously very non-normal
hist(training$capitalAve)
qqnorm(training$capitalAve)

#imputing missing data
set.seed(13343)

#throw some NA's into the data
training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1], size=1, prob=0.05)==1
training$capAve[selectNA] <- NA

#imput and standardize
preObj <- preProcess(training[,-58], method="knnImpute")
capAve <- predict(preObj, training[,-58])$capAve

#standardize true values
capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth - mean(capAveTruth))/sd(capAveTruth)

mean(capAve);sd(capAve)
mean(capAveTruth);sd(capAveTruth)
