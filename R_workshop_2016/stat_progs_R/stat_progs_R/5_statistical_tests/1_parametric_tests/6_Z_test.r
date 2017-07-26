# Demonstrates the hypothesis testing with Normal distribution.

#------------------------------------------------------------------
#          Test the given mean with parent mean.

# testing agains normal distribution of known mean
#   and standard deviation  (ie.,normal N(mu,sigma))

# x has 10 data points

#x =  c(2.0,8.5,3.4,8.2,3.9,6.9,5.8,1.0,4.8,5.5)
x =  c(5.0,8.8,6.4,8.2,3.8,6.9,5.3,1.0,4.7,5.5)


# mean of Guassian for testing (parent mean)
mu = 5.0
# parent Standard deviation
sigma = 2.0

# Z parameter

   n = length(x)
   Z = (mean(x) - mu)/(sigma/sqrt(n))

# get the p-value from unit Gaussian
pvalue = 1 - pnorm(Z)

print("p-value : ")
print(pvalue)


#------------------------------------------------------------------------------

#  Testing two samples from Gaussian distribution with known varience of population.

   # two data sets X and Y
   X = c(5.7,6.9,10.7,2.2,4.9,1.3,8.1,4.8,1.1,5.4,7.9,3.9
)
   Y = c(4.6,6.1,1.6,6.7,3.8,2.7,7.7,6.2,2.0,6.1,6.9,8.6)


   # parent means 
   muX = 5.0
   muY = 5.3

   # parent SD
   sigmaX = 2.0
   sigmaY = 2.1

   nX = length(X)
   nY = length(Y)

  
   combinedSD = sqrt( (sigmaX^2/nX) + (sigmaY^2/nY) )

   meandiff = (mean(X)-mean(Y)) - (muX - muY)  

   Z = meandiff/combinedSD

   pvalue = 1 - pnorm(Z)

   print(pvalue)

#----------------------------

   

