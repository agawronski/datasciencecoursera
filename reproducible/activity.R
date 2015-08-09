setwd("C:/Users/aidan/data_science/datasciencecoursera/reproducible")
library(lubridate)

data <- read.csv("activity.csv")
data$date <- ymd(data$date)

plot(data$date, data$steps)

#Mean number of steps taken per day
data$day <- day(data$date)
uniqueDays <- unique(data$day)

df <- NULL

for (d in uniqueDays) {
  row <- c(d, mean(data$steps[data$day==d]))
  df <- rbind(df, row)
}
