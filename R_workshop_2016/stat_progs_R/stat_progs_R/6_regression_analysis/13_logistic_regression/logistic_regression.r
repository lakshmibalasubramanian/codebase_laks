# Read the data on cars.
# This data is internal data sets of R. Data from 1972 moton trend US magazine.

# In R, type help(mtcars) to get details of data. 

# mpg   Miles/(US) gallon                        
# cyl   Number of cylinders                      
# disp  Displacement (cu.in.)                    
# hp    Gross horsepower                         
# drat  Rear axle ratio                          
# wt    Weight (lb/1000)                         
# qsec  1/4 mile time                            
# vs    V/S                                      
# am    Transmission (0 = automatic, 1 = manual) 
# gear  Number of forward gears                  
# carb  Number of carburetors     

  dat = read.table("cars.CSV", header=TRUE)

# Transmission "am" is a logistic data.

# We will first find how manual transmission is related to horse power of engine.
# Using Logistic regression, compute the probability of vehicle fitted with manual
#  transmission if horse power hp=120.
# We use glm function.
# glm function performed generalized linear model to give p-values for the variable hp.

  am.glm = glm(formula=am ~ hp, data=dat, family=binomial) 

  # print the details like slope 'a' and intercept 'b' in  logit( P(am=1) ) = a + b*hp
  print( summary(am.glm) )

  # convert hp=120 into a frame
  newdata = data.frame(hp=120)
  
  # 'predict' is a generic function that grabs appropriate values from fitting models in R.
  pr = predict(am.glm, newdata, type="response")

  probability = as.numeric(pr)

  print("probability : ")
  print(probability)

  print("-----------------------------------------------------------" ) 

#------------------------------------------------------------------------------------------------

# We will now find how manual transmission is related to horse power of engine and weight.
# Using Logistic regression, compute the probability of vehicle fitted with manual
#  transmission if horse power hp=120 and weight=2.8 
# We use glm function.
# glm function performed generalized linear model to give p-values for the variable hp and wt.


  am.glm1 = glm(formula=am ~ hp + wt, data=mtcars, family=binomial)
  
  print( summary(am.glm1) )

  newdata = data.frame(hp=120, wt=2.8)

  pr1 = predict(am.glm1, newdata, type="response") 

  probability = as.numeric(pr1)

  print("probability : ")
  print(probability)

#-----------------------------------------------------------------------------------------------




