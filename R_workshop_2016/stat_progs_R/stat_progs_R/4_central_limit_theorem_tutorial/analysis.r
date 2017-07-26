# Analysis of height-weight data for understanding Gaussian distribution

# Load data file
data <- read.table("SOCR_height_weight_data.txt", header=TRUE)

# See names of columns
colnames(data)

#convert inches to cm in height
height <- data$Height.Inches * 2.54

# convert weight from pounds to Kg
weight <- data$Weight.Pounds * 0.45359

par(mfrow=c(2,1))

# Plot the histogram of height
hist(height, breaks=50, col="blue", xlim=c(150,200), ylim=c(0,2000) )
# Plot the histogram of weight
hist(weight, breaks=50, col="blue", xlim=c(30, 90), ylim=c(0,2000))

X11()

par(mfrow=c(2,1))

# Get mean height and mean weight
height_mean <- mean(height)
weight_mean <- mean(weight)

# Get SD of height and weight
sd_height <- sd(height)
sd_weight <- sd(weight)

# Plot histograms of mean subtracted data
hist(height-height_mean, breaks=60, col="blue")
hist(weight-weight_mean, breaks=60, col="blue")

# Plot the normal data and mean subtracted data for height side by side
par(mfrow=c(2,1))
hist(height, breaks=50, col="blue")
hist(height-height_mean, breaks=50, col="blue")

X11()
# Plot the normal data and mean subtracted data for weight side by side
par(mfrow=c(2,1))
hist(weight, breaks=50, col="blue")
hist(weight-weight_mean, breaks=50, col="blue")

X11()

# Now, Normalize the data with (data-mean)/SD
norm_height <- (height - height_mean)/sd_height
norm_weight <- (weight - weight_mean)/sd_weight

# Plot the normalized data. Now the X-axis is in units of standard deviations.
hist(norm_weight, breaks=50, col="blue")
X11()
hist(norm_height, breaks=50, col="blue")

# To compare, for height and weight, plot normal data, mean subtracted data and normalized data
par(mfrow=c(2,3))
hist(height, breaks=50, col="blue")
hist(height-height_mean, breaks=50, col="blue")
hist(norm_height, breaks=50, col="blue")

hist(weight, breaks=50, col="blue")
hist(weight-weight_mean, breaks=50, col="blue")
hist(norm_weight, breaks=50, col="blue")

# Superimpose the two normalized distributions with add=T options
hist(norm_height, breaks=50, col="blue")
hist(norm_weight, breaks=50, col="red", add=T)

