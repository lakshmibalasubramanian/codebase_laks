#Gaussian distribution with the dataset of height & weight of basketball players from the given file SOCR_height_weight_data.txt

data = read.table("SOCR_height_weight_data.txt", header = TRUE)
print(names(data))
height = data$Height.Inches*2.54
weight = data$Weight.Pounds*0.45359
#height[1:10]
#weight[1:10]
hist(height,breaks = 30, col = "blue")
hist(weight, breaks = 30, col = "purple")

#plotting 4 graphs in a same screen (canvas)
par(mfrow = c(2,2)) #This command will split the screen into 2*2
hist(height,breaks = 40, col = "blue")
hist(((height - mean(height))/sd(height)), breaks = 40 , col = "blue")  #(x-mu)/sigma (normalised height)
hist(weight,breaks = 40, col = "pink")
hist(((weight - mean(weight))/sd(weight)), breaks = 40 , col = "pink")  #(x-mu)/sigma (normalised height)

par(mfrow = c(1,1))
z = seq(-4,4,0.2)
y = dnorm(z) #density of gaussian for a given z value it gives a density value
plot(z,y)
dnorm(2.5)
pnorm(0)
pnorm(1)-pnorm(-1)
pnorm(3) - pnorm(-3)
pnorm(3.75)


x = c(7.5,8.0,7.8,6.7,6.2,8.8,9.4,8.1,5.7,8.4)
mu = 8
sigma = 1.5
Z = (mean(x) - mu)/(sigma/sqrt(length(x)))
Z
p = pnorm(Z)  #this is the statistical probability
p



n = 10
sigma = 1.5
mu = 8
x = rnorm(n,mu,sigma)
z = (mean(x) - mu)/(sigma/sqrt(n))
z
p = 1-pnorm(z)
p
