# Sam Woodman
# Analysis of spacial statistic R
# General, Desne, and Sparse Specific Testing

library(dplyr)
setwd("~/Google Drive/Semester 8/Thesis/NetLogo+R GitHub/BehaviorSpace Data/R Value/")

### General Testing
g.data <- read.csv("Bees R values-table.csv", header = TRUE, skip = 6)[,c(2,3,4,5,8)]

## Filter data by dense and sparse
g.data <- g.data %>% filter(c1_mult >= c2_mult)
g.data.dense <- filter(g.data, g.data$resource_density == "\"dense\"")
g.data.dense.r <- g.data.dense$R
g.data.sparse <- filter(g.data, g.data$resource_density == "\"sparse\"")
g.data.sparse.r <- g.data.sparse$R

## Divide data into groups .03 away from: R = 0.4, 0.6, 0.8, 1.0
# Dense
g.data.dense.4 <- g.data.dense %>% filter(abs(R - 0.4) <= 0.03)
g.data.dense.6 <- g.data.dense %>% filter(abs(R - 0.6) <= 0.03)
g.data.dense.8 <- g.data.dense %>% filter(abs(R - 0.8) <= 0.03)
# Sparse
g.data.sparse.4 <- g.data.sparse %>% filter(abs(R - 0.4) <= 0.03)
g.data.sparse.6 <- g.data.sparse %>% filter(abs(R - 0.6) <= 0.03)
g.data.sparse.8 <- g.data.sparse %>% filter(abs(R - 0.8) <= 0.03)


### Dense Testing
d.data.all <- read.csv("Bees R dense testing-table.csv", header = TRUE, skip = 6)[-c(6,7,9)]
d.data.all$grp <- (floor((d.data.all$X.run.number.-1) / 20)) + 1
d.data <- d.data.all %>% filter(c1_mult >= c2_mult)

## Divide data into groups d.num away from: R = 0.4, 0.6, 0.8
d.num <- 0.01
d.data.4 <- d.data %>% filter(abs(R - 0.4) <= d.num)
temp.4 <- which.max(table(d.data.4$grp)) 
d.idx.4 <- (20 * as.numeric(names(temp.4))) # Best sequence is d.data.all[3941:3960,]
d.data.all[d.idx.4,]

d.data.6 <- d.data %>% filter(abs(R - 0.6) <= d.num)
temp.6 <- which.max(table(d.data.6$grp)) # Best sequence is d.data.all[1581:1600,]
d.idx.6 <- 20 * as.numeric(names(temp.6))
d.data.all[d.idx.6,]

d.data.8 <- d.data %>% filter(abs(R - 0.8) <= d.num)
temp.8 <- which.max(table(d.data.8$grp)) # Best sequence is d.data.all[821:840,]
d.idx.8 <- 20 * as.numeric(names(temp.8))
d.data.all[d.idx.8,]


### Sparse Testing
s.data.all <- read.csv("Bees R sparse testing_10rep-table.csv", header = TRUE, skip = 6)[-c(6,7,9)]
s.data.all$grp <- (floor((s.data.all$X.run.number.-1) / 10)) + 1
s.data <- s.data.all %>% filter(c1_mult >= c2_mult)

## Divide data into groups s.num away from: R = 0.4, 0.6, 0.8
s.num <- 0.05
s.data.4 <- s.data %>% filter(abs(R - 0.4) <= s.num)
temp.4 <- which.max(table(s.data.4$grp)) 
s.idx.4 <- (10 * as.numeric(names(temp.4))) # Best sequence is s.data.all[4831:4840,]
s.data.all[s.idx.4,]

s.data.6 <- s.data %>% filter(abs(R - 0.6) <= s.num)
temp.6 <- which.max(table(s.data.6$grp)) # Best sequence is s.data.all[5741:5750,]
s.idx.6 <- 10 * as.numeric(names(temp.6))
s.data.all[s.idx.6,]

s.data.8 <- s.data %>% filter(abs(R - 0.8) <= s.num)
temp.8 <- which.max(table(s.data.8$grp)) # Best sequence is s.data.all[3381:3390,]
s.idx.8 <- 10 * as.numeric(names(temp.8))
s.data.all[s.idx.8,]
