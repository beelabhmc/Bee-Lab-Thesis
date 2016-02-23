# Sam Woodman
# Testing for significant differences between expected resources and observed resources

library(dplyr)
setwd("~/Google Drive/Semester 8/Thesis/NetLogo GitHub/BehaviorSpace Data/Resource_num/")

## Is number of resources significantly different from expected?
resource.num <- read.csv("Bees resource_nums_10-table.csv", header = TRUE, skip = 6)
resource.num <- read.csv("Bees resource_nums_20+R-table.csv", header = TRUE, skip = 6)
resource.num <- resource.num %>% filter(c1_mult >= c2_mult)

perform.t.test <- function(idx) {
  to.test <- idx:(idx+9)
  results <- t.test(resource.num$count.patches.with..resource..[to.test] - resource.num$num.patches.r[to.test])
  results$p.value
}

idx.unique <- which(!duplicated(resource.num[-c(1,9)]))
p.vals <- sapply(idx.unique, function(x)  perform.t.test(x))
sum(p.vals <= 0.05)
sum(p.vals <= 0.05)/length(idx.unique)
idx.sig <- 10 * which(p.vals <= 0.05)
idx.sig

## Analysis of significantly different 
resource.num.sig <- resource.num[idx.sig,]
table(resource.num.sig$resource_density)


