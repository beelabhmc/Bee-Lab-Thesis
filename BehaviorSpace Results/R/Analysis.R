# Sam Woodman
# Analysis of spacila statistic R

library(dplyr)

setwd("~/Google Drive/Semester 8/Thesis/NetLogo GitHub/BehaviorSpace Results/R")
r.data <- read.csv("Bees R testing-table.csv", header = TRUE, skip = 6)

r.data <- r.data %>% filter(c1_mult >= c2_mult)
r.data.dense <- filter(r.data, r.data$resource_density == "\"dense\"")
r.data.dense.r <- r.data.dense$R
r.data.sparse <- filter(r.data, r.data$resource_density == "\"sparse\"")
r.data.sparse.r <- r.data.sparse$R

t.test(r.data.dense$R,r.data.sparse$R)
