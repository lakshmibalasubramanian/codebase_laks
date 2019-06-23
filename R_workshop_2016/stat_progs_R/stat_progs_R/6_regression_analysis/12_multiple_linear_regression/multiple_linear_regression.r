# Multiple linear regression

# Read the data file.
# Data has 4 variables. The effect of Air.Flow, Water.Temp and Acid.Conc on stack.loss is studied.
data <- read.table("stackloss.CSV", header=TRUE)

# Perform multiple linear regression. stack.loss is dependent variable,
#   other three are independent variables.
fitlm = lm(stack.loss ~ Air.Flow + Water.Temp + Acid.Conc., data=stackloss)

# print the summary. This has all information from the regression model
print(summary(fitlm))

print("------------------------------------------")

# From the model fit, predict the value of stack.loss for a fixed value
#   of the independent parameters.
newdata = data.frame(Air.Flow=72, Water.Temp=20, Acid.Conc.=85)

pr = predict(fitlm, newdata) 

print("For the value of Air.Flow=72, Water.Temp=20 and Acid.Conc.=85,  the value of stack.loss
from the multiple linear regression is : ")

print(as.numeric(pr))

print("-------------------------------------------")

# Get the 95% confidence interval around mean for the data 
confint = predict(fitlm, newdata, interval="confidence",level=0.95)

print("95% confidence interval : ")

print(confint)
 

  
