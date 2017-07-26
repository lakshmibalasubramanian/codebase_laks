#x = c(5.1,4.8,5.1,4.3,8.4,7.6,7.5,3.8,2.8,6.2)
#y = c(5.6,3.9,6.8,6.8,5.7,6.2,7.5,6.1,6.4,4.2,4.7,5.4)
x = rnorm(14,mean = 5.0, sd = 1.0)
y = rnorm(16, mean = 3.0, sd = 1.0)
#sigmax = 1.3
#sigmay = 1.3
xbar = mean(x)
ybar = mean(y)
m = length(x)
n = length(y)
m
n
nullhyp = (xbar - ybar)/sqrt(((sigmax^2)/m) + ((sigmay^2)/n))

nullhyp

