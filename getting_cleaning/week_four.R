download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv ", destfile="./getting_cleaning/q4d1.csv")
data <- read.csv("./getting_cleaning/q4d1.csv")
splitnames <- strsplit(names(data),"wgtp")
#answer 1 
splitnames[123]

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="./getting_cleaning/q4d2.csv")
gdp <- read.csv(file="./getting_cleaning/q4d2.csv", stringsAsFactors=FALSE, nrows=190, blank.lines.skip=TRUE, skip=4)
clean_gdp <- as.numeric(gsub(",", "", gdp[,5]))
#answer 2
mean(clean_gdp)

#question 3
gdp <- gdp[,c(1,2,4,5,6)]
names(gdp) <- c("country","gdp_rank","countryNames","USD","alpha")
#answer 3
grep("^United", gdp$countryNames, value=TRUE)

#question 4
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="./getting_cleaning/q4d2.csv")
#gdp <- read.csv(file="./getting_cleaning/q4d2.csv", stringsAsFactors=FALSE, nrows=190, blank.lines.skip=TRUE, skip=4)
#gdp <- gdp[,c(1,2,4,5,6)]
#names(gdp) <- c("country","gdp_rank","countryNames","USD","alpha")
gdp$gdp_rank <- as.numeric(gdp$gdp_rank)
gdp$USD <- as.numeric(gsub(",", "", gdp$USD))
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv ", destfile="./getting_cleaning/q4d4.csv")
educ <- read.csv("./getting_cleaning/q4d4.csv")

combine <- merge(gdp, educ, by.x="country", by.y="CountryCode", all=FALSE)
sub <- combine[grepl("Fiscal year end: June", combine[,14])==TRUE,]
#answer 4
dim(sub)

# question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
#first part of answer five
l_2012 <- grepl("2012",sampleTimes)
sum(l_2012)
#second part of answer five
l_Monday <- grepl("Monday",weekdays(sampleTimes))
sum(l_2012*l_Monday)
