library(caret)

setwd("C:/Users/aidan/data_science/datasciencecoursera/practical_machine_learning/project")

data <- read.csv("pml-training.csv", stringsAsFactors=FALSE)

test <- read.csv("pml-testing.csv", stringsAsFactors=FALSE)

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

#fitting initial model with random forests

control <- trainControl(ntree=100, mtry=7)


fit <- train(classe ~ ., method="LogitBoost", data=data)





