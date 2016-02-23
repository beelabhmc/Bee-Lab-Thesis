# Sam Woodman
# Analysis of spacial statistic R

library(dplyr)
setwd("~/Google Drive/Semester 8/Thesis/NetLogo GitHub/BehaviorSpace Data/R Value/")
r.data <- read.csv("Bees R values-table.csv", header = TRUE, skip = 6)[,c(2,3,4,5,8)]

## Filter data by dense and sparse
r.data <- r.data %>% filter(c1_mult >= c2_mult)
r.data.dense <- filter(r.data, r.data$resource_density == "\"dense\"")
r.data.dense.r <- r.data.dense$R
r.data.sparse <- filter(r.data, r.data$resource_density == "\"sparse\"")
r.data.sparse.r <- r.data.sparse$R

## Divide data into groups .03 away from: R = 0.4, 0.6, 0.8, 1.0
# Dense
r.data.dense.4 <- r.data.dense %>% filter(abs(R - 0.4) <= 0.03)
r.data.dense.6 <- r.data.dense %>% filter(abs(R - 0.6) <= 0.03)
r.data.dense.8 <- r.data.dense %>% filter(abs(R - 0.8) <= 0.03)
# Sparse
r.data.sparse.4 <- r.data.sparse %>% filter(abs(R - 0.4) <= 0.03)
r.data.sparse.6 <- r.data.sparse %>% filter(abs(R - 0.6) <= 0.03)
r.data.sparse.8 <- r.data.sparse %>% filter(abs(R - 0.8) <= 0.03)
