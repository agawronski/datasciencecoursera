library(caret)
data(faithful)
set.seed(333)
inTrain <- createDataPartition(y=faithful$waiting, p=0.5, list=FALSE)

trainFaith <- faithful[inTrain,]
testFaith <- faithful[-inTrain,]
head(trainFaith)
plot(trainFaith$eruptions, trainFaith$waiting, pch=19, col="blue", xlab="waiting", ylab="duration")

lm1 <- lm(eruptions ~ waiting, data=trainFaith)
summary(lm1)

plot(trainFaith$waiting, trainFaith$eruptions, pch=19, col="blue", xlab="waiting", ylab="duration")
lines(trainFaith$waiting, lm1$fitted, lwd=3)

#predict a new value
coef(lm1)[1] + coef(lm1)[2]*80

#or like this
newdata <- data.frame(waiting=80)
predict(lm1, newdata)
