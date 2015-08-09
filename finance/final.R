# VPACX annualized cc mean
avpacx_mu <- 0.43*12
avpacx_sd <- 5.59*sqrt(12)

t_bills <- 0.08
at_bills <- 0.08*12

avpacx_sr <- (avpacx_mu - at_bills)/avpacx_sd

# vbltx annualized cc mean
avbltx_mu <- 0.49*12
avbltx_mu

avbltx_sd <- 2.9*sqrt(12)
avbltx_sd

avbltx_sr <- (avbltx_mu - at_bills)/avbltx_sd
avbltx_sr

# veiex annualized cc mean
aveiex_mu <- 1.28*12
aveiex_mu

aveiex_sd <- 8.45*sqrt(12)
aveiex_sd

aveiex_sr <- (aveiex_mu - at_bills)/aveiex_sd
aveiex_sr

# 
mu <- c(0.43, 0.49, 1.28)
a <- c(0.45, 0.28, 0.27)
b <- c(-0.22, 1.71, -0.49)
c <- c(0.33, 0.33, 0.33)
d <- c(-0.74, 1.15, 0.58)

# tangency weights 
t_mu <- 1.76
0.62*t_mu + 0.38*t_bills 

#t bills have no sd
# sd of tangency port 6.53%
efficient_sd <- sqrt((0.55^2)*(5.63^2))
efficient_sd

#weights of the global minimum variance portfolio
gmvp_weights <- c(0.23, 0.87, -0.1)
gmvp_mu <- 0.004 # 0.4%
gmvp_sd <- 0.0284 # 2.84%

VaR <- 100000*(exp(gmvp_mu - (1.645*gmvp_sd)) - 1)
VaR

1.00139- 0.08194
1.5262-(3*0.1214)
