getwd()
setwd("C:/Users/Debakshi/Documents/R_learn")
##How to create functions
squarenum=function(vec,num){
  s=(vec^2/num)
  ss=sum(s)
  sa=sqrt(ss)
  return(sa)
}
v1=c(20,30,40,50,60,70)
vec=squarenum(v1,200)
print (vec)
##Install and installed packages
installed.packages()
install.packages("ggplot")
library("ggplot")
library("ggplot2")
library("cluster")
install.packages("grid")
install.packages("lattice")
install.packages("plot3d")
install.packages("plot3D")
##Making plots in R
x=c(1,2,3,4,5,6,7,8)
y=c(21,31,45,57,69,95,88,99)
length(x)
length(y)
plot(x,y)
#adding attributes
plot(x,y,pch= 5)#shape of point
plot(x,y,pch= 5, cex=6.7)#size of the point
plot(x,y,pch= 5,cex=1.5, col="purple")#color of the point
plot(x,y,pch= 5,cex=1.5, col="purple",type="p")#points;scatter
plot(x,y,pch= 5,cex=1.5, col="purple",type="l")#line
plot(x,y,pch= 5,cex=1.5, col="purple",type="h")#histo
plot(x,y,pch= 5,cex=1.5, col="purple",type="b")#both line and points
plot(x,y,pch= 5,cex=1.5, col="purple",type="o")#overlay
plot(x,y,pch= 5,cex=1.5, col="pink",type="l", lty=5, lwd=2)#lty-type of line and lwd-line width
plot(x,y,pch= 5,cex=1.5, col="purple",type="l",main="TPLOT",col.main="violet",font.main=7, cex.main=05)
#You need to put a qualifier for changing title related stuff (col.main)
plot(x,y,pch= 5,cex=1.5, col="purple",type="p",xlab="LALALA",ylab="Intensity",font.lab=1.5,cex.lab=3,col.lab="green")
#Label is the axes titles
plot(x,y,pch= 5,cex=1.5, col="purple",type="p",xlim =c(1,100),ylim=c(1,100))#Limits of the axes
plot(x,y,pch= 5,cex=1.5, col="black",type="o",log="y")#getting it in log scale
plot(x,y,pch= 20,cex=1.5, col="black",type="o",log="x")#Filled points
##### Making a barplot (this is from countbio.com, under R graphics)
# Define a data vector
data = c(1,3,6,4,9)

#bar plot the vector -- simple plot with no legends and colors
barplot(height=data, main="Cancer-data", xlab="Days", ylab="Response Index", 
        names.arg=c("grp-1","grp-2","grp-3","grp-4","grp-5"),
        border="blue", density=c(10,20,30,40,50))

###### Create a data frame
col1 <- c(1,3,6,4,9)
col2 <- c(2,5,4,5,12)
col3 <- c(4,4,6,6,16)

data <- data.frame(col1,col2,col3)
names(data) <- c("patient-1","patient-2","patient-3")

# barplot with colors. Make sure that the plot and legends have same colors for items.
barplot(height=as.matrix(data), main="Experiment-1", ylab="dosage", beside=FALSE,#for making columns vs in same bar
        col=rainbow(5))

#Add legends
legend("topleft", c("day1","day2","day3","day4","day5"), cex=1.0, bty="n",
       fill=rainbow(5))
####When you have several y values for one x axis 

# define 3 data sets
xdata <- c(1,2,3,4,5,6,7)
y1 <- c(1,4,9,16,25,36,49)
y2 <- c(1, 5, 12, 21, 34, 51, 72)
y3 <- c(1, 6, 14, 28, 47, 73, 106 )

# plot the first curve by calling plot() function
# First curve is plotted
plot(xdata, y1, type="o", col="red", pch="o", lty=1, ylim=c(0,110) )

# Add second curve to the same plot by calling points() and lines()
# Use symbol '*' for points.
points(xdata, y2, col="green", pch="*")
lines(xdata, y2, col="green",lty=2)

# Add Third curve to the same plot by calling points() and lines()
# Use symbol '+' for points.
points(xdata, y3, col="blue",pch="+")
lines(xdata, y3, col="blue", lty=3)
text(7,45,"red",col = "red")##Adds text next to the curve
#Add the legend
legend(1,60,legend=c("y1","y2","y3"), col=c("red","green","blue"),pch=c("o","*","+"),lty=c(1,2,3), ncol=1)
#####################Many plots in the same page
par(mfrow = c(2,2))
##  Set up plotting in two rows and three columns.
##  Set the outer margin for bottom, left, and right as 0 and
##  outer margin for top is 2 lines of text.
##  Plotting goes along rows first.
##  To plot along columns, usde "mfcol" instead of mfrow.
par( mfrow = c( 2, 3 ), oma = c( 0, 0, 2, 0 ) )

## Call the first plot. This is drawn at the location row 1, column 1:
## simple (X,Y) plot
plot(c(1,2,3,4,5,6),c(10,18,29,42,55,66), type="b", col="blue", main="Figure-1(A)",
     xlab="X-value", ylab="Y-value")

## Call the second plot. This is drawn at the location row 1, column 2:
## We generate 2 sets of 100 uniform random numbers and create their scatter plot. 
## "runif(100)" returns 100 uniform random numbers between 0 and 1.
plot(runif(100), runif(100), col="red", pch = 8, xlab="deviate-1",
     ylab="deviate-2", main="Figure-1(B)")

##Call the third plot. This is located in row 1, column 3:
## "rnorm(10000)"generate a histogram of 10000 gaussian deviates
hist(rnorm(10000), breaks=30, col="springgreen4", xlim = c(-5,5), xlab="Unit Gaussian Z value",
     ylab="Frequency", main="Figure-1(C)")

## Call the fourth plot. It is located in row 2, column 1:
## We generate 20 poinrs from a Poisson distribution and plot them.
plot( rpois(n=20, lambda=5), type = "h", col="purple", xlab="Poisson deviate : mean=5", 
      ylab="frequency", main="Figure-1(D)")

##  plot.new() skips a position, if needed.


##  The fifth plot is located in row 2, column 2:
# Create a Pie chart with a heading and rainbow colors
result <- c(10, 30, 60, 40, 90)
pie(x = result, main="Figure-1(E)", col=rainbow(length(result)), 
    label=c("Mol-1","Mol-2","Mol-3", "Mol-4", "Mol-5"))

## The sixth plot is located in row 2, column 3
# we create a list of vectors and call box plot with it.
# Three Box-Whiskers are plotted, for x, y and x vectors
x <- c(1,5,7,8,9,7,5,1,8,5,6,7,8,9,8,6,7,8,10,19,6,7,8,6,4,6) 
y = x*1.5
z = x*2.3
alis <- list(x,y,z)
boxplot(alis, range=0.0, horizontal=FALSE, varwidth=TRUE, notch=FALSE,
        outline=TRUE, names=c("A","B","C"), boxwex=0.3, 
        border=c("blue","blue","blue"), col=c("red","red","red"), main="Figure-1(F)")

# Title is given to the whole of the plot.
title("A visual summary of the results", outer=TRUE)