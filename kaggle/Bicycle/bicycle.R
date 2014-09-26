# Testing Gopinath's random forest solution 
# http://www.techdreams.org/programming/solving-kaggles-bike-sharing-demand-machine-learning-problem/9343-20140821
library(caret)
library(lubridate)
library(randomForest)

setwd("C:/Users/aidan/data_science/datasciencecoursera/kaggle/Bicycle")

training <- read.csv("train.csv")
testing <- read.csv("test.csv")

# names(training)
# [1] "datetime"   "season"     "holiday"    "workingday" "weather"    "temp"      
# [7] "atemp"      "humidity"   "windspeed"  "casual"     "registered" "count"  

#compute hour of day
training$hour <- hour(training$datetime)
testing$hour <- hour(testing$datetime)

#comput day of the week
training$dow <- wday(training$datetime)
testing$dow <- wday(testing$datetime)

testing$count <- 0
# create a random forest
fit <- randomForest(as.factor(training$count) ~ training$season + training$holiday + training$weather + training$dow + training$hour + training$temp + training$atemp + training$humidity + training$windspeed, date=training, ntree=700, importance=TRUE)
varImpPlot(fit)
