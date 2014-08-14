library(tseries)

# Procter and gamble
# na.locf removes NA and carries forward the most recent non NA value
PG <- na.locf(get.hist.quote("PG", quote="Adj", start="2005-12-25", retclass="zoo"))

# To make week end prices:
nextfri.Date <- function(x) 7 * ceiling(as.numeric(x - 1)/7) + as.Date(1)
w.PG <- aggregate(PG, nextfri.Date,tail,1)

# To convert month end prices:
m.PG <- aggregate(PG, as.yearmon, tail, 1)

# Convert weekly prices into weekly returns
lwr.PG <- diff(log(wPG)) # convert prices to log returns
swr.PG <- exp(wr.PG)-1          # back to simple returns

# Convert monthly prices into monthly returns
lmr.PG <- diff(log(mPG))  # convert prices to log returns
smr.PG <- exp(rm.PG)-1   

# Write output data to csv file
write.zoo(swr.PG, file="swr_PG.csv",sep=",",col.names=c("Dates","Percent Return"))
write.zoo(smr.PG, file="smr_PG.csv",sep=",",col.names=c("Dates","Percent Return"))


