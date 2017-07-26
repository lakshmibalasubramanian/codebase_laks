
              # Generation of uniform random numbers without and with seeds.
            #-------------------------------------------------------------------

# Generate a uniform random number in the range [0,1]
#  By default, uses “Mersenne-twister” algorithm.

runif(n=1)
# This also works
runif(1)

# generate 10 random  numbers between [0,1] and print it.
yr = runif(10)
print(yr)

# we can control the digits of random number with roundup function:
yr = round(yr, digits=4)
print(yr)

# histogram 10000 numbers between [0,1]
hist(runif(10000))

# Generate 10 uniform deviates between min and max
runif(10, min=4, max=10)
#This is same as above
runif(10, 3, 4)




# Sophisticated generation with seed and with choices – using RNGkind.

# It is done in 3 steps.

# 1. set the random generator. Only once in the beginning
    RNGkind(kind = 'Mersenne-Twister', normal.kind =  'default')

# 2. Set the seed value once. All subsequent calls to runf will have
#          same seed, unless changed again by the same command.
    rand_seed =  12353
    set.seed(rand_seed)

# 3. call with runf() as many times as you want. It will be same seed.
    Y = runif(10)

# Now, if you again call set.seed(seedval) with different seedvalue, 
# you get another sequence for new seed.


# choices for random number generators : 'kind' values:
# random_generator   = "Mersenne-Twister"   ---> default kind.
#                    = "Wichmann-Hill"
#                    = "Marsaglia-Multicarry"
#                    = "Super-Duper"
#                    = "Knuth-TAOCP-2002"
#                    = "Knuth-TAOCP"
#                    = "L'Ecuyer-CMRG"

# This option not used.  'normal.kind' values
# normal_distribution_generation =  Inversion"   ---> default
#                                = "Kinderman-Ramage"
#                                = "Buggy Kinderman-Ramage"
#                                = "Ahrens-Dieter"
#                                = "Box-Muller"
#                                = "user-supplied"
#                                = NULL  --> selects currently used algorithm for
#                                            normal kind.



