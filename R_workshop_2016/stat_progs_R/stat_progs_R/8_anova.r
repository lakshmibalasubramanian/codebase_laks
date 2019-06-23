dat = read.table("insect_sprays.txt", header=TRUE, sep='\t')

mean(dat$count[dat$spray=="A"])
mean(dat$count[dat$spray=="B"])
mean(dat$count[dat$spray=="C"])
mean(dat$count[dat$spray=="D"])
mean(dat$count[dat$spray=="E"])

tapply(dat$count, dat$spray, mean) 
tapply(dat$count, dat$spray, length)

boxplot(dat$count ~ dat$spray)

# one way anova test. Default assumption is variances not equal.
oneway.test(dat$count~dat$spray)

# To make variences equal, set parameter
oneway.test(dat$count~dat$spray,var.equal=TRUE)

# Run anov function
aov.out = aov(count ~ spray, data=InsectSprays)
summary(aov.out)

# see pdf file ANOVA_in_R.pdf attached. (from web, auther unknown) 



)



