library(ISLR)
library(caret)
data(Wage)

inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dummies <- dummyVars(wage ~ jobclass, data=training)
head(predict(dummies, newdata=training))

#removing zero covariates
nsv <- nearZeroVar(training, saveMetrics=TRUE)
nsv
# saveMetrics true shows you how it is calculating unimportant covariates
# in terms of low or no variability

#Spline basis
library(splines)
#create a polynomial variable (third degree polynomial in this case)
bsBasis <- bs(training$age, df=3)
bsBasis

# Fitting curves with splines
lm1 <- lm(wage ~ bsBasis, data=training)
plot(training$age, training$wage, pch=19, cex=0.5)
points(training$age, predict(lm1, newdata=training), col="red", pch=19, cex=0.5)

# Splines on the test set must be done using the exact same proceedure as the training set
predict(bsBasis, age=testing$age)
#these values are the values you plug into the model when testing the test set
