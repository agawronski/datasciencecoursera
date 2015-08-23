library(caret)

setwd("C:/Users/aidan/data_science/datasciencecoursera/practical_machine_learning/project")

data <- read.csv("pml-training.csv", stringsAsFactors=FALSE)

testing <- read.csv("pml-testing.csv", stringsAsFactors=FALSE)

head(data$classe)

dim(data)

dim(data[complete.cases(data),])

str(data)

#removing variables that are mostly na's

na <- apply(is.na(data), 2, sum)
keep <- na[na==0]
keep <- names(keep)

data <- data[,keep]

#removing character variables which are mostly empty

naChar <- apply(data, 2, function(x) sum(x==""))
keep <- naChar[naChar==0]
keep <- names(keep)

data <- data[,keep]

#removing character variables for inital model, may add them back later

data <- data[,-which(names(data)%in%c("X", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp", "new_window"))]

data$classe <- as.factor(data$classe)


#______________________________________________________________________________________

#Make split the training set

new <- createDataPartition(data$classe, p=0.7, list=FALSE)

train <- data[new,]
firstTest <- data[-new,]


#fitting initial model with gbm


fit <- train(classe ~ ., method="gbm", data=train)

predict <- predict(fit, test)

table <- table(predict, test$classe)

confusionMatrix(predict, test$classe)


