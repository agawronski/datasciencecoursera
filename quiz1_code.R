x <- 1:4 # Question 9
y <- 2:3 # Question 9

x + y # Question 9
what <- x + y
class(what)
t <- list(2,"a","b",TRUE) # Question 8
t[[2]] # Question 8
class(t[[2]]) # Question 8
what2<-t[[2]]
class(what2)
x <- c(1,3, 5) # question 6
y <- c(3, 2, 10) # question 6
rbind(x,y) # question 6
class(rbind(x,y))
x <- c(4, "a", TRUE) #testing for question 5
class(x) #testing for question 5
x<-4  #testing for question 4
class(x) #testing for question 4
x <- c(17, 14, 4, 5, 13, 12, 10) # question 10
x # question 10
x[x>4]<-10 # question 10
x
data<-read.csv("hw1_data.csv", header=TRUE)  # load data for q11 onward

getwd()
dim(data)
names(data)
data[1:2,] #q12
nrows(data)
dim(data) #q13
data[152:153,] #q14
data[47,1] #q15
data[47,]
mo<-is.na(data[,1])
mo
table(mo)
nan<-is.nan(data[,1])
table(nan)
dirt_oz<-data[,1]
dirt_oz
mo<-is.na(dirt_oz) 
mo
table(mo) #q16
ozone<-dirt_oz[!mo]
dim(ozone)
ozone
length(ozone)
mean(ozone) #q17
mean(dirt_oz)
data
dirt_data<-data
rm(data)
dim(mo)
dirt_data
data<-dirt_data[!mo,1:6]
data
dim(data)
names(data)
over31<-data[,]
dim(over31)
q18<-data[with(data, Ozone>31 & Temp>90),]
q18
dirt_data
q18
mean_q18<-mean(q18[,2])
mean_q18
q19<-data[data$Month==6,]
q19
mean_q19<-mean(q19[,4])
mean_q19
dirt_data
test<-dirt_data[dirt_data$Month==6,]
test
mean_q19test<-mean(test[,4])
mean_q19test
dim(q19)
dim(test)
rq18<-dirt_data[with(dirt_data, Ozone>31 & Temp>90),]
rq18
mean_rq18<-mean(q18[,2])
mean_rq18
max(data[data$Month==5,1])
x <- c(4, TRUE) #second try at the quiz
class(x)
x <- c(1,3, 5)
y <- c(3, 2, 10)
cbind(x, y)
class(cbind(x, y))
x <- 1:4
y <- 2
x + y
x <- c(3, 5, 1, 10, 12, 6)
x[x <= 5] <- 0
x

