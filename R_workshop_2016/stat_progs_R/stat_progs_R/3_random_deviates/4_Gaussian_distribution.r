
# Generating random deviates in R.

# For every distribution, we can generate 4 things:

#   1. probability density    ---  'd' before name of distribution
#   2. p_value for a given Z value – 'p' before name of distribution
#   3. Z-value for a given p-value --- 'g' before name of distribution
#   4. random deviate from distribution --- 'r' before name of distribution

### Generating data from normal distributions.


#  1. Gaussian distribution.


## For Normal(Gaussian) distribution, the 4 functions in R are demonstrated

######------------------------------------------------------
## 1. dnorm(x)
## Given a x or a vector of x, returns the height of probability distribution 
## function at each x from N(0,1) curve, or N(mean, sigma)

## Examples:

print(dnorm(0)) # value 0.3989 of N(0,1) at x=0

print(dnorm(1))

# value of normal dist. with a  mean standard deviation
print(dnorm(1.5, mean=2.5, sd=1.2))

# we can generate many numbers
x <- seq(-20,20, by=0.1)
y <- dnorm(x)
plot(x,y)

y <- dnorm(x, mean=0.0, sd=4.0)
plot(x,y, cex=0.3, col='blue')

#####----------------------------------------------------------------------

### 2.  pnorm(x)
### Given a x or a list of x, computes a normally distributed random number 
## less than the value. (cumulative distribution function. This is integral
## of N(0,1) from minus infinity to that point.).  
## This is p-value for a given z value 

print(pnorm(0))  # prints 0.5, which is p-value for z=0

print(pnorm(1))  # prints 0.8413, which is p-value for z = 1

print(pnorm(2) - pnorn(-2)) # prints 0.954 (two sigma value)

print(pnorm(3) - pnorm(-3)) # prints 0.779 (3 sigma value)

####--------------------------------------------------------------------

### 3.  qnorm(x)
### Given a probability p, gives the corresponding Z-score for N(0,1)

print(qnorm(0))  # prints minus infinity
print(qnorm(1))  # print plus infinity
print(qnorm(0.5)) # prints zero
print(qnorm(0.3)) # prints -0.524 for Z
print(qnorm(0.95)) # prints a z value of 1.644
####------------------------------------------------------------------------

### 4.   rnorm(x)
#### Generates n random points(deviates) on a gaussian distribution
print(rnorm(5)) # prints 5 points on N(0,1)

print(rnorm(5, mean=3, sd=1)) # 5 points from N(3,2)

# histogram of 10000 points from gaussian deviates.
xx = rnorm(10000)
hist(x)

####------------------------------------------------------------


#----------------------------------------------------------------------------------








