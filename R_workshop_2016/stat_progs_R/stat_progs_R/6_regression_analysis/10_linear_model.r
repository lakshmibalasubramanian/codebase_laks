#  Linear regression in R

# lm is used to fit linear models

xdat <- c(1,2,3,4,5,6,7,8,9,10)

#ydat <- c(15, 25, 35, 45, 55, 65, 75, 85, 95, 105)
ydat <- c(16.5, 23.3, 35.5, 45.8, 57.9, 68.0, 73.4, 89.0, 97.9, 107.0)
df <- data.frame(x=xdat, y=ydat)

dat <- lm(y~x, df)
# In the above formuls, use y~x-1 if you don't want intercept

# slope
print(dat$coefficients[1])

# intercept
print(dat$coeffcients[2])

#fitted values
print(dat$fitted.values)

# To see 95% confidence interval
confint(dat, level=0.95)



# A summary of entire analysis
print(summary(dat))

# plot the results
plot(xdat,ydat, col="red")
lines(xdat, dat$fitted.values, col="blue")

# To see the residual plots
plot(dat)


##-----------------------------------------------------------------------------------
## fit with errors (weights) on individual data points
xdat <- c(1,2,3,4,5,6,7,8,9,10)

#ydat <- c(15, 25, 35, 45, 55, 65, 75, 85, 95, 105)
ydat <- c(16.5, 23.3, 35.5, 45.8, 57.9, 68.0, 73.4, 89.0, 97.9, 107.0)

# errors on data points
#errors = c(3.0, 4.1, 5.0, 5.5, 6.0, 6.2, 6.9, 9.0, 11.2, 10.7)
#errors = sqrt(ydat) Error is nothing but a standard deviation
errors = c(3.0, 4.1, 5.0, 5.5, 6.0, 6.2, 1.0, 1.0, 1.0, 1.0)

df = data.frame(x = xdat, y=ydat, err=errors)

data = lm(y~x, data = df, weights = 1/df$err)

print(data)



ylim=range(c(ydat-errors, ydat+errors))

# plot the results
plot(xdat,ydat,col="red")
lines(xdat, data$fitted.values, col="blue")

arrows(xdat, ydat-errors, xdat, ydat+errors, length=0.05, angle=90, code=3)


