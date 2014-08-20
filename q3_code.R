library(datasets)

data(iris)

names(iris)

mean(iris[iris$Species=="virginica","Sepal.Length"])

library(datasets)
data(mtcars)
?mtcars

hp_cyl<-split(mtcars$hp, mtcars$cyl)
