## Trevor Stephens Titanic tutorial
## http://trevorstephens.com/post/72918760617/titanic-getting-started-with-r-part-1-booting-up-r

setwd("C:/Users/aidan/data_science/datasciencecoursera/kaggle/titanic")
train <- read.csv("train.csv")
View(train)
test <- read.csv("test.csv")
View(test)

prop.table(table(train$Survived))

test$survived <- rep(0, 418)
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$survived)
write.csv(submit, file="morbid.csv", row.names=FALSE)

summary(train$Sex)
prop.table(table(train$Sex, train$Survived),1)

test$Survived <- 0
test$Survived[test$Sex=="female"] <- 1
submit2 <- data.frame(PassengerId = test$PassengerId, Survived=test$Survived)
write.csv(submit2, file="women.csv", row.names=FALSE)

summary(train$Age)
train$Child <- 0
train$Child[train$Age < 18] <- 1
aggregate(Survived ~ Child + Sex, data=train, FUN=sum)
aggregate(Survived ~ Child + Sex, data=train, FUN=length)

aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

train$Fare2 <- "30+"
train$Fare2[train$Fare >=20 & train$Fare < 30] <- "20-30"
train$Fare2[train$Fare >=10 & train$Fare < 20] <- "10-20"
train$Fare2[train$Fare < 10] <- "10"

aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

library(rpart)
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method="class")
library(rattle)
library(rpart.plot)
library(RColorBrewer)
fancyRpartPlot(fit)

Prediction <- predict(fit, test, type="class")
submit3 <- data.frame(PassengerId = test$PassengerId, Survived=Prediction)
write.csv(submit3, file="CART.csv", row.names=FALSE)

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method="class", control=rpart.control(minsplit=30, cp=0.01))
fancyRpartPlot(fit)

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train,
             method="class", control=rpart.control( your controls ))
new.fit <- prp(fit,snip=TRUE)$obj
fancyRpartPlot(new.fit)

# Feature engineering
rm(list=ls())
train <- read.csv("train.csv")
#View(train)
test <- read.csv("test.csv")
#View(test)

test$Survived <- NA
combi <- rbind(train, test)
combi$Name <- as.character(combi$Name)

# Create a new title variable
combi$Title <- sapply(combi$Name, FUN=function(x) {strsplit(x, split="[,.]")[[1]][2]})
combi$Title <- sub(" ", "", combi$Title)
table(combi$Title)

#combine Mlle and Mme
combi$Title[combi$Title %in% c("Mme", "Mlle")] <- "Mlle"

#combine Capt Don Major and Sir into Sir
combi$Title[combi$Title %in% c("Capt", "Don", "Major", "Sir")] <- "Sir"

#combine Dona Lady the Countess Jonkheer into Lady
combi$Title[combi$Title %in% c("Dona", "Lady", "the Countess", "Jonkheer")] <- "Lady"

combi$Title <- as.factor(combi$Title)

#create family size variable
combi$FamilySize <- combi$SibSp + combi$Parch + 1

#last name variable
combi$Surname <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})

#family identifier variable
combi$FamilyID <- paste(as.character(combi$FamilySize), combi$Surname, sep="")
famIDs <- data.frame(table(combi$FamilyID))

famIDs <- famIDs[famIDs$Freq <= 2,]
combi$FamilyID[combi$FamilyID %in% famIDs$Var1] <- 'Small'
combi$FamilyID <- factor(combi$FamilyID)

#Aidan's feature engineering ideas explore
combi$Cabin2 <- as.character(combi$Cabin)
combi$Cabin2[combi$Cabin2==""]  <- NA
combi$Cabin2 <- as.factor(combi$Cabin2)
Cabin2fit <- rpart(Cabin2 ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + Age + FamilySize,
                data=combi[!is.na(combi$Cabin2),], method="class",  control=rpart.control(minsplit=5, cp=0.05))

combi$Cabin2[is.na(combi$Cabin2)] <- predict(Cabin2fit, combi[is.na(combi$Cabin2),])

combi$Cabin2[grepl("A", combi$Cabin)] <- "A"
combi$Cabin2[grepl("B", combi$Cabin)] <- "B"
combi$Cabin2[grepl("C", combi$Cabin)] <- "C"
combi$Cabin2[grepl("D", combi$Cabin)] <- "D"
combi$Cabin2[grepl("E", combi$Cabin)] <- "E"
combi$Cabin2[grepl("F", combi$Cabin)] <- "F"


train <- combi[1:891,]
test <- combi[892:1309,]

# new tree
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID,
             data=train, method="class")

fancyRpartPlot(fit)
Prediction <- predict(fit, test, type="class")

submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file="features.csv", row.names=FALSE)

#RANDOM FORESTS ...begin at feature enginering
summary(combi$Age)

#We need to fill in the NA vales for AGE... and we will use a decision tree to do so
#Notice method ANOVA for continues variables
Agefit <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FamilySize,
                data=combi[!is.na(combi$Age),], method="anova")

combi$Age[is.na(combi$Age)] <- predict(Agefit, combi[is.na(combi$Age),])

summary(combi)
#notice that Embarked has two blanks, we fill them in somewhat arbitrarily with S
which(combi$Embarked=='')
combi$Embarked[c(62,830)] = "S"
combi$Embarked <- factor(combi$Embarked)
#Fare has one NA value
which(is.na(combi$Fare))
combi$Fare[1044] <- median(combi$Fare, na.rm=TRUE)

#convert family ID to character string adjust adjust the size
combi$FamilyID2 <- combi$FamilyID
combi$FamilyID2 <- as.character(combi$FamilyID2)
combi$FamilyID2[combi$FamilySize <= 3] <- 'Small'
combi$FamilyID2 <- factor(combi$FamilyID2)
library(randomForest)
set.seed(415)
train <- combi[1:891,]
test <- combi[892:1309,]
fit <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize +
                      FamilyID2, data=train, importance=TRUE, ntree=1000)
varImpPlot(fit)
Prediction <- predict(fit, test)
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "ranforth.csv", row.names = FALSE)


linear <- lm(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilyID2, data=train)
predict_linear <- predict(linear, test)
submit <- data.frame(PassengerId = test$PassengerId, Survived = predict_linear)
write.csv(submit, file = "ols.csv", row.names = FALSE)

#logistic
logit <- glm(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilyID2, data=train, family="binomial")
predict_logit <- predict(logit, test)
submit <- data.frame(PassengerId = test$PassengerId, Survived = predict_linear)
write.csv(submit, file = "ols.csv", row.names = FALSE)

#EXPLORING the data
#Seems like Family of four of less has alot of survivors
with(train, plot(Age, FamilySize, col=as.factor(Survived)))
     
