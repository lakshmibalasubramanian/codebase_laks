#Kruskal-Wallis Rank-sum test, non-parametric alternative to anova.
dat = read.table("insect_sprays.txt", header=TRUE, sep='\t')

mean(dat$count[dat$spray=="A"])
mean(dat$count[dat$spray=="B"])
mean(dat$count[dat$spray=="C"])
mean(dat$count[dat$spray=="D"])
mean(dat$count[dat$spray=="E"])

tapply(dat$count, dat$spray, mean) 
tapply(dat$count, dat$spray, length)

boxplot(dat$count ~ dat$spray)

kr = kruskal.test(count ~ spray, data=InsectSprays)

print(kr)

# str(kr) gives the output quantities by name

stat = as.numeric(kr$statistic)
print(stat)
#etc

