library(plot3D)

# X,Y and Z values
x = c(1,2,3,4,5)
y = c(1,2,3,4,5)
zval = c(20.8, 22.3, 22.7, 11.1, 20.1, 2.2,  6.7,  14.1, 6.6,  24.7, 15.7, 15.1, 9.9,  9.3,  14.7, 8.0,  14.3, 5.1,  6.5,  19.7, 21.9, 11.2, 11.6, 3.9,  14.8 )
# Convert Z values into a matrix.
z = matrix(zval, nrow=5, ncol=5, byrow=TRUE)
hist3D(x,y,z, zlim=c(0,50), theta=40, phi=40, axes=TRUE,label=TRUE, nticks=5,ticktype="detailed", space=0.5, lighting=TRUE, light="diffuse", shade=0.5)

##### for saving plots
install.packages("Cairo")
library(Cairo)
## Initialize the device for saving first plot.
## Plot will have length=500 pixel, width=500 pixel
## saved as a png image file called "testfile1.png"

Cairo(file="testfile1.png",
      type="png",
      units="px", 
      width=500, 
      height=500, 
      pointsize=12, 
      dpi="auto")

## Now render the plot 
x = rnorm(10000)
hist(x, col="red")

## When the device is off, file writing is completed.
dev.off()


## Initialize the device for saving second plot.
## Plot will have length=400 pixel, width=300 pixel
## saved as a png image file called "testfile2.jpg"

Cairo(file="testfile2.jpg",
      type="png",
      units="px", 
      width=400, 
      height=300, 
      pointsize=12, 
      dpi="auto")

## Now render the plot 
x = c(1,2,3,4,5,6)
y = c(10,20,30,40,50,60)

plot(x,y,col="red", type="b")

## When the device is off, file writing is completed.
dev.off()

