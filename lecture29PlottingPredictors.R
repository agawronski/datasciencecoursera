#predicting wages
library(ISLR); library(ggplot2); library(caret);library(gridExtra)
data(Wage)
summary(Wage)

inTrain <- createDataPartition(Wage$wage, p=0.7, list=FALSE)

training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dim(training); dim(testing)

featurePlot(x=training[,c("age", "education", "jobclass")], 
            y=training$wage, 
            plot="pairs")
qplot(age, wage, data=training)
qq <- qplot(age, wage, data=training, colour=education)
qq + geom_smooth(method="lm", formula=y~x)

library(Hmisc)
cutWage <- cut2(training$wage, g=3)
table(cutWage)

p1 <- qplot(cutWage, age, data=training, fill=cutWage, geom=c("boxplot"))
p1
p2 <- qplot(cutWage, age, data=training, fill=cutWage, geom=c("boxplot", "jitter"))
p2
grid.arrange(p1,p2,ncol=2)

t1 <- table(cutWage, training$jobclass)
t1
prop.table(t1,1)
prop.table(t1,2)

qplot(wage, colour=education, data=training, geom="density")
