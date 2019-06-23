
# polynomial fit using lm

 x = c(0.5, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0)

 y = c(0.87, 7.12, 14.01, 24.37, 39.058, 58.62, 83.92)

# We can also simulate data
# y = x + x^2 + x^3
# introduceing a gaussian error
#for(i in 1:length(ydat))
#{
#y[i] = rnorm(7, mean=y[i],sd=y[i]*0.002)
#}
 
 result = lm(y ~ x + I(x^2) + I(x^3))


 # accessing coefficient of x
 print(result$coefficient[[1]]) 

  # accessing coefficient of x^2
 print(result$coefficient[[2]]) 


 # accessing coefficient of x^3
 print(result$coefficient[[3]]) 

#plot original points and the fitted curve

plot(x,y,type="p", col="blue")

yfitted = result$coefficient[[1]]*x + result$coefficient[[2]]*x^2 + result$coefficient[[3]]*x^3 


lines(x,yfitted, type="l",col="red")




# non-linear curve fitting with nls function
# ----------------------------------------------------------------------------


# non-linear data is fitted with nls() function, by method of least squares.

# we fit a power model.

# We first generate data y = x^3 + gaussian noise

# NOTE : here we simulate xdat,ydat with npoints.
# Instead, actual data can be give to these vectors.

# xdat is independent variable, It is generated as a sequence
xdat <- seq(1, 3, 0.1)
npoints = length(xdat)

# ydat is xdat cubed plus some gaussian noise to simulate deviations. 
ydat <- xdat^3 + rnorm(npoints, 0, 1.0)

df <- data.frame(x = xdat, y = ydat)

s <- seq(1, 3, 0.1)
#lines(s, s^3, lty = 2, col = "green")

#dat <- nls(y ~ I(x^power), data=df, start=list(power=1), trace=T)
dat <- nls(y ~ I(x^power), data=df)

print(class(dat))

print(summary(dat))

print(summary(dat)$coefficients)

power <- round(summary(dat)$coefficients[1], 3)

power.se <- round(summary(dat)$coefficients[2], 3)



s <- seq(1, 3, 0.1)
plot(ydat ~ xdat, main = "Fitted power model", sub = "Blue: fit; green: known")
lines(s, s^3, lty = 2, col = "green")
lines(s, predict(dat, list(x = s)), lty = 1, col = "blue")

text(1, 20, paste("y =x^ (", power, " +/- ", power.se,")", sep = ""), pos = 4)


# We also fit a formula
data = lm(formula = log(x)~y)

summary(data)



