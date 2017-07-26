x = rnorm(14,mean = 5.0, sd = 1.0)
y = rnorm(16, mean = 3.0, sd = 1.0)

res = t.test(x,y,alternative = c("two.sided"), paired = FALSE, var.equal = FALSE, conf.level = 0.95)
# var.equal = false means it is welch's t-test
res
