library(caret)
library(kernlab)
data(spam)
set.seed(32343)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=FALSE)

training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)

modelFit <- train(type ~ . , data=training, method="glm")
modelFit
modelFit$finalModel

predictions <- predict(modelFit, newdata=testing)
predictions
sum(predictions==testing$type)
sum(predictions==testing$type)/length(predictions)

confusionMatrix(predictions, testing$type)
