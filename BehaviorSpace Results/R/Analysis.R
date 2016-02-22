# Sam Woodman
# Analysis of spacial statistic R

library(dplyr)
setwd("~/Google Drive/Semester 8/Thesis/NetLogo GitHub/BehaviorSpace Results/R")

## Is number of resources significantly different from expected?
resource.num <- read.csv("Bees resource_nums_10-table.csv", header = TRUE, skip = 6)
resource.num <- resource.num %>% filter(c1_mult >= c2_mult)

perform.t.test <- function(idx) {
  to.test <- idx:(idx+9)
  results <- t.test(resource.num$count.patches.with..resource..[to.test] - resource.num$num.patches.r[to.test])
  results$p.value
}

idx.unique <- which(!duplicated(resource.num[-c(1,9)]))
p.vals <- sapply(idx.unique, function(x)  perform.t.test(x))
sum(p.vals <= 0.05)
idx.sig <- 10 * which(p.vals <= 0.05)
idx.sig

# Analysis of significantly different 
resource.num.sig <- resource.num[idx.sig,]
resource.num$resource_density[10 * which(p.vals <= 0.05)]
# 9 sparse and 19 dense


## R spatial statistics
r.data <- read.csv("Bees R testing-table.csv", header = TRUE, skip = 6)[,c(2,3,4,5,8)]

r.data <- r.data %>% filter(c1_mult >= c2_mult)
r.data.dense <- filter(r.data, r.data$resource_density == "\"dense\"")
r.data.dense.r <- r.data.dense$R
r.data.sparse <- filter(r.data, r.data$resource_density == "\"sparse\"")
r.data.sparse.r <- r.data.sparse$R

