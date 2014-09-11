setwd("C:/Users/aidan/data_science/datasciencecoursera")

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(url, destfile="./getting_cleaning/q1.csv")
data <- read.csv("./getting_cleaning/q1.csv")

data$new <- ifelse((data$ACR>2 & data$AGS>5), TRUE, FALSE)
agricultureLogical <- data$new

#answer to question 1
head(which(agricultureLogical), n=3) # 125 238 262

#question 2 install jpeg package
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile="./getting_cleaning/leek.jpg", mode="wb")
image_data <- readJPEG("./getting_cleaning/leek.jpg", native=TRUE)
#answer to q2
quantile(image_data, probs=c(0.3,0.8)) #-15259150 -10575416 

#question 3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv ", destfile="./getting_cleaning/gdp.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv ", destfile="./getting_cleaning/educ.csv")
gdp <- read.csv(file="./getting_cleaning/gdp.csv", stringsAsFactors=FALSE, nrows=190, blank.lines.skip=TRUE, skip=4)
gdp <- gdp[,c(1,2,4,5,6)]
names(gdp) <- c("country","gdp_rank","economy","USD","alpha")
gdp$gdp_rank <- as.numeric(gdp$gdp_rank)
gdp$USD <- as.numeric(gsub(",", "", gdp$USD))

educ <- read.csv("./getting_cleaning/educ.csv")


df <- merge(gdp, educ, by.x="country", by.y="CountryCode",all=FALSE)
#partial answer
dim(df)
#second part of answer
s_df <- df[order(df$gdp_rank, decreasing=TRUE),]
s_df[13,c("country","Long.Name")]

#question number 4
tapply(s_df$gdp_rank, s_df$Income.Group, mean)

#question number 5 uses Hmisc package, create group_five and table against Income.Group
library(Hmisc)
group_five <- cut2(s_df$gdp_rank,g=5)
#answer
table(group_five, s_df$Income.Group)


