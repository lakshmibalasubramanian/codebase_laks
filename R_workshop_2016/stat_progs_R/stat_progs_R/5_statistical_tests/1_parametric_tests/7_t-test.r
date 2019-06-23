# Demonstrating one sample and two sample t-test on vectors of data


##------------------------------------------------
# One sample t-test ("t-test against zero")
#

# Generate randomly 10 data points from N(0,1).
# gives large p-value since 10 random points don't give mean zero!!!
x <- rnorm(10, mean=0, sd=1)

# Perform t-test. Default is two sided
result <- t.test(x)
print(result)

# see the structure
print(str(result))
# get t-value
print(result$statistic)

# get p-value
print(result$p.value)


# Another example.
# Since these points have mean zero, p-value is 1!!
x <- c(-0.8, -0.6, -0.4, -0.2, 0.2, 0.4, 0.6, 0.8)
print(t.test(x))

#----------------------------------------------

# Two sample t-test  with two unpaired data sets.
# Assumption : unqual mean, difference in means is zero, equal variance

# instead of simulated vectors below, we can give real vectors x and y from data
x <- rnorm(10, mean=5, sd=2)
y <- rnorm(10, mean=8, sd=2)

result <- t.test(x,y,paired=FALSE)

print(result)

# since mean difference is large, very small p-value
x <- rnorm(10, mean=4, sd=1.8)
y <- rnorm(10, mean=8, sd=1.8)

result <- t.test(x,y, paired=FALSE, var.equal=TRUE)

print(result)



### NOTE : we can test against a difference in mean between 2 sample which is
##            other than zero. use parameter mu=1.5  for example

#---------------------------------------------------------------

## two sample Welsch test
## Assumtion : unequal mean, variance of 2  data sets are not equal.
x <- rnorm(10, mean=5, sd=2)
y <- rnorm(10, mean=8, sd=3)

# Note that we are getting a 99% confident interval
result <- t.test(x,y,paired=FALSE, var.equal=FALSE, conf.level=0.99, alternative="two.sided")

print(result)

##-----------------------------------------------------------------------------







