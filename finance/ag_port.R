setwd("C:/Users/aidan/data_science/datasciencecoursera/finance")
library(quantmod)

tickers <- c("NKE", #NIKE INC
             "TIF", #TIFFANY & CO
             "SNP", #CHINA PETROLEUM & CHEMICAL CORP
             "AHL", #ASPEN INSURANCE HOLDINGS LTD
             "OPLK", #OPLINK COMMUNICATIONS INC
             "EIX", #EDISON INTERNATIONAL
             "CCK", #CROWN HOLDINGS INC
             "MGM", #MGM RESORTS INTERNATIONAL
             "PEP", #PEPSICO INC
             "SYK", #STRYKER CORPORATION
             "GS",  #GOLDMAN SACHS GROUP INC
             "TM",  #TOYOTA MOTOR CORP
             
             "ORB", #ORBITAL SCIENCES CORP
             "JPM", #JPMORGAN CHASE & CO
             "MMM", #3M CO
             "BKS", #BARNES & NOBLE INC
             "PFE", #PFIZER INC
             "ANAD", #ANALOG DEVICES INC
             "DOW", #DOW CHEMICAL CO
             "BBY", #BEST BUY CO INC
             "SWC", #STILLWATER MINING CO
             "SCHL" #SCHOLASTIC CO
             )

getSymbols(tickers)

returns <- cbind(monthlyReturn(NKE), #NIKE INC
                 monthlyReturn(TIF), #TIFFANY & CO
                 monthlyReturn(SNP), #CHINA PETROLEUM & CHEMICAL CORP
                 monthlyReturn(AHL), #ASPEN INSURANCE HOLDINGS LTD
                 monthlyReturn(OPLK), #OPLINK COMMUNICATIONS INC
                 monthlyReturn(EIX), #EDISON INTERNATIONAL
                 monthlyReturn(CCK), #CROWN HOLDINGS INC
                 monthlyReturn(MGM), #MGM RESORTS INTERNATIONAL
                 monthlyReturn(PEP), #PEPSICO INC
                 monthlyReturn(SYK), #STRYKER CORPORATION
                 monthlyReturn(GS),  #GOLDMAN SACHS GROUP INC
                 monthlyReturn(TM),  #TOYOTA MOTOR CORP
             
                 monthlyReturn(ORB), #ORBITAL SCIENCES CORP
                 monthlyReturn(JPM), #JPMORGAN CHASE & CO
                 monthlyReturn(MMM), #3M CO
                 monthlyReturn(BKS), #BARNES & NOBLE INC
                 monthlyReturn(PFE), #PFIZER INC
                 monthlyReturn(ANAD), #ANALOG DEVICES INC
                 monthlyReturn(DOW), #DOW CHEMICAL CO
                 monthlyReturn(BBY), #BEST BUY CO INC
                 monthlyReturn(SWC), #STILLWATER MINING CO
                 monthlyReturn(SCHL) #SCHOLASTIC CO
)

names(returns) <- tickers
returns <- log(1 + returns)

library(tseries)

#$pw portfolio weights
#$px portfolio returns
#$pm portfolio mean return (monthly)
#$ps portfolio standard deviation (monthly)

min <- portfolio.optim(returns, shorts=TRUE)
twenty <- portfolio.optim(returns, pm=0.2, shorts=TRUE)

weights <- cbind(tickers, twenty$pw)
rebalance <- twenty$pw*90000

rebalance <- cbind(weights, rebalance)
View(rebalance)
