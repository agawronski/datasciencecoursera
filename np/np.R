library("np")
data("cps71")
model.par <- lm(logwage ~ age + I(age^2), data = cps71)
summary(model.par)

model.np <- npreg(logwage ~ age, 
                  regtype = "ll", 
                  bwmethod = "cv.aic", 
                  gradients = TRUE, 
                  data = cps71)
summary(model.np)
npsigtest(model.np)

plot(cps71$age, cps71$logwage, xlab = "age", ylab = "log(wage)", cex=.1)
lines(cps71$age, fitted(model.np), lty = 1, col = "blue")
lines(cps71$age, fitted(model.par), lty = 2, col = " red")
plot(model.np, plot.errors.method = "asymptotic")
plot(model.np, gradients = TRUE)
lines(cps71$age, coef(model.par)[2]+2*cps71$age*coef(model.par)[3],
         lty = 2,
         col = "red")
plot(model.np, gradients = TRUE, plot.errors.method = "asymptotic")

cps.eval <- data.frame(age = seq(10,70, by=10))
predict(model.par, newdata = cps.eval)
predict(model.np, newdata = cps.eval)
