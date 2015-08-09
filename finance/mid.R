w <- c(0.384, 0.605, 0.432, 0.551)
pvar <- (w^2)*3 + ((1-w)^2)*2.5 + 2*w*(1-w)*0.9
pvar



pr <- w*2 + (1-w)*1
pr



(.4^2)*3 +(0.6^2)*2.5 + 2*(0.4)*(0.6)*(0.9)

vf1 <- 105.06
vf2 <- 109.04
Rf <- (vf2-vf1)/vf1
rf <- log(1+Rf)
annual_Rf <- exp(12*rf)-1
annual_rf <- 12*rf
10000*(1+annual_Rf)


ve1 <-28.64
ve2 <- 29.49
Re <- (ve2-ve1)/ve1
re <- log(1+Re)
annual_Re <- exp(12*re)-1
annual_re <- 12*re
10000*(1+annual_Re)

pR <- 0.2*Rf + 0.8*Re
pr <- log(1+pR)

# rVFINX∼ iid N(0.001,(0.05)2),
# (Hint: qZ0.05=−1.645)
muf <- 0.001
sdf <- 0.05
VaRf <- 100000*(exp(muf - 1.645*sdf)-1)

# rVEIEX∼ iid N(0.01,(0.09)2).
# (Hint: qZ0.05=−1.645)
mue <- 0.01
sde <- 0.09
VaRe <- 100000*(exp(mue - 1.645*sde)-1)

# annual f var
VaRf <- 100000*(exp(12*muf - 1.645*(sdf*sqrt(12)))-1)

# annuale var
VaRe <- 100000*(exp(12*mue - 1.645*(sde*sqrt(12)))-1)

3/(1-0.45)
(1.5^2)/(1-(0.45^2))
(1.5^2)/(1-(0.45^2))*.45 #Covariance
