library(httr)
library(jsonlite)
#call back when creating the app was http://localhost:1410
oauth_endpoints("github")
my_gitapp  <- oauth_app("github", "20dab3449afcd4ef1741", "90a498d941f726087a1f3809c5b2efc85d4682ec")
git_token <- oauth2.0_token(oauth_endpoints("github"), my_gitapp)
gtoken <- config(token = git_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
response <- content(req)

clean <- fromJSON(toJSON(response))
names(clean)


head(clean)
x <- clean[clean$url=="https://api.github.com/repos/jtleek/datasharing",]
#answer to question 1
x$created_at #"2013-11-07T13:25:07Z"

#2
library(sqldf)
acs <- read.csv("./getting_cleaning/survey_data.csv")

reg <- unique(acs$AGEP)

#4 use nchar()
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html <- readLines(con)
close(con)

answerdf <- html[c(10, 20, 30, 100)]
answer <- sapply(answerdf, nchar, USE.NAMES=FALSE) # [1] 45 31  7 25

#5 fixed width format read.fwf
data <- read.fwf("./getting_cleaning/fixed_width.for", skip=4, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
sum(data[,4])
