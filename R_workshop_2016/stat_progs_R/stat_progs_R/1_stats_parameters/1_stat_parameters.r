#                    Compute basic statistical parameters
#-----------------------------------------------------------------------------

x <- c(5.6, 2.7, 6.7, 8.2, 3.9, 4.5, 9.2, 7.7, 6.1, 11.0, 10.0, 5.0)

# Getting basic statistical summary of vector in one go.
y <- summary(x)

# convert it into proper numerical array
y = as.numeric(y)
print(y)

# y is a vector
# y[1] is minimum value
# y[2] is first quartile
# y[3] is median
# y[4] is mean
# y[5] is third quartile
# y[6] is maximum


# We can also use ndividual functions

# mean value
meanValue <- mean(x)

#median value
medianValue = median(x)

#variance
variance = var(x)

#standard deviation 
standardDeviation = sd(x)

# Box-Whisker plot
boxplot(x)



