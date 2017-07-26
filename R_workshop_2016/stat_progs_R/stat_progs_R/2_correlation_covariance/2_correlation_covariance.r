# Given two vectors xx and yy, we can get the covarience and 
# correlation coefficient
#--------------------------------------------------------------------------------

xx <- c(1,2,3,4,5,6,7)
yy <- c(11, 23, 32,40, 51, 64, 76)

# covarience
covarianceValue = cov(xx,yy)

#correlation coefficient
correlationValue = cor(xx,yy)

print(covarianceValue)

print(correlationValue)


