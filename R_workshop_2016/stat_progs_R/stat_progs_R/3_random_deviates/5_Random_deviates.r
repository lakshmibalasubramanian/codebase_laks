
#                     Generating random deviates in R.
#--------------------------------------------------------------

# For every distribution, we can generate 4 things:

#   1. probability density    ---  'd' before name of distribution
#   2. p_value for a given Z value – 'p' before name of distribution
#   3. Z-value for a given p-value --- 'g' before name of distribution
#   4. random deviate from distribution --- 'r' before name of distribution

#-------------------------------------------------------------------------------

# 1.  Guassian (normal) distributions


# random values from normal distribution with mean 10 and standard deviation 3
y = rnorm(10,mean=10, sd=3)


# ## Given a x or a vector of x, returns the height of probability distribution 
## function at each x from N(0,1) curve, or N(mean, sigma)
y = dnorm(0) # # value 0.3989 of N(0,1) at x=0
y = dnorm(1) # value of N(0,1) at x = 1
# value of normal dist. with a  mean standard deviation
y = dnorm(1.5, mean=2.5, sd=1.2)

# p-value for a given Z-value
y = pnorm(0)  # y is 0.5, which is p-value for z=0
y = pnorm(1)  # y is 0.8413, which is p-value for z = 1
y = pnorm(3) - pnorm(-3)) # prints 0.779 (3 sigma value)


# Z value for a given p-value
y = qnorm(0)  # y is minus infinity
y = qnorm(1)  # y is plus infinity
y = qnorm(0.5) # y is zero
y = qnorm(0.3)) # y is -0.524 for Z
y = qnorm(0.95)) # y is now the z value of 1.644



#----------------------------------------------------------------------------
 
#   2. Binomial distributions

#  npoints =  number of points randomly sampled from distribution
#  ntrial = number of trials
#  prob = probability 'p' of success in a trial

#y = rbinom(npoints, ntrials, prob)
y = rbinom(5, 10, 0.5) # returns 5 random deviate from a binomial
                       # distribution of p=0.5, n=10

#  Refer to dbinom(), pbinom() and qbinom() in R-manuals or in help(dbinom) etc.

#----------------------------------------------------------------------------------



#   3.  Poisson deviates

  #npoints =  number of points randomly sampled from distribution
   
  # mean = mean value (mu) of Poisson distributions

  # y = rpois(npoints,mean)

   y = rpois(10, 12) # y has 10 random samples from a Poisson  of mean 12
   
   
   # Refer to dpois(), ppois() and qpois() in R-manuals or in help(dpois) etc. 

# -----------------------------------------------------------------------------

#   4.  Negative Binomial distributions

# npoints = number of data points to be generated from distributions

# nsuccesses = number of successes

prob = probability for binomial process (probability of success in a trial)

# y = rnbinom(npoints, nsuccesses, prob)  # y is the trial required until 
                                          #    we hit nsuccesses

  y = rnbinom(15, 8, 0.5) #  generates 15 values from a negative binomial
                          # of 8 succeses with probability of a success p = 0.5

 # Refer to dpois(), ppois() and qpois() in R-manuals or in help(dpois) etc. 

#--------------------------------------------------------------------------------

#   5.  Gamma distributions

# npoints = number of data points to be randomly sampled from distributions

# shape = shape parameter k of gamma distributions (k = 1.2.3,..

# scale =  scale parameter theta of the gamma distribition. 
#                     (theta = 0.1,0.2,...1.0) value 0 to 1


# y = rgamma(npoints, shape, scale) 

  y = rgamma(12, 2.0, 0.3) # y has 10 data points drawn from gamma distribution of
                           #  shape = 2 and scale=0.3

# Refer to dgamma(), pgamma() and qgamma() in R-manuals or in help(dpois) etc. 

#-----------------------------------------------------------------------------

#    6.  Weibull distribution

# npoints = number of data points to be randomly sampled from distributions
# shape = shape parameter k of Weibull distributions
# scale =  scale parameter theta of the Weibull distribition

#  y = rweibull(npoints, shape, scale)
#------------------------------------------------------------------------
#    7. Chi-Square distribution

#   chisquare =  chi-square value for which p to be found.
#   df  = degrees of freedom

#    y = pchisq(chisqiare, df) # gives p-value for df degrees of freedom 
     y = pchisq(5.5, 12)  

#    y  = rchisq(n,df)  # returns n data points from a chisuqare distribution with 
                         # df degrees of freedom

     y = rchisq(10,22)


#  similarly
#  qchisq(p,df) where p is a probability or vector of probabilities

#  dchisq(x,df) where x is the chisquare value for whuch density is needed.

# there is a choice for 'non-centrality' factor. See help(rchisq)

#-------------------------------------------------------------------------------

#    8.  t-distribution  

#  functions are 't' added to p,r,d,p

# tvalue = t statistic
# df = degrees of freedom

# y= pt(tvalue, df) # given a t-valur get p-value for degreess of freedom df.

  Y = pt(7.5, 20)

#-------------------------------------------------------------------

#   9.  f-distribution

# the functions are 'f' added after p,r,d,p

# df1, df2  are the 2 degrees of freedom.

# f-value is the value of F statistic

#  y = pf(fvalue , df1=15, df2=20) # p value for given fvalue, df1 and df2

y = pf(3.7,15,20) # gives p-value fot the F value 3,7, df1=15 nd df2=20

y = rf(50, 15, 20) # returns 50 random deviates from an F-distribution 
                   #   of df1=15,df2-20

#----------------------------------------------------------------------------------
