# Sam Woodman
# Analysis of spacial statistic R
# General, Desne, and Sparse Specific Testing

library(dplyr)
setwd("~/Google Drive/Semester 8/Thesis/NetLogo+R GitHub/BehaviorSpace Data/R Value/")

### General Testing
g.data <- read.csv("Bees R extra_sparse testing1-table.csv", header = TRUE, skip = 6)

## Filter data by dense and sparse
data.e.sparse <- filter(g.data, g.data$resource_density == "\"extra_sparse\"")
data.e.sparse.r <- data.e.sparse$R
data.e.sparse$grp <- (floor((data.e.sparse$X.run.number.-1) / 7)) + 1
data.e.sparse <- data.e.sparse %>% filter(c1_mult >= c2_mult)


## Divide data into groups .03 away from: R = 0.4, 0.6, 0.8, 1.0
# Extra-sparse
data.e.sparse.4 <- data.e.sparse %>% filter(abs(R - 0.4) <= 0.07)

data.e.sparse.6 <- data.e.sparse %>% filter(abs(R - 0.6) <= 0.03)
table(data.e.sparse.6$grp)
temp.6 <- which.max(table(data.e.sparse.6$grp)) 
es.idx.6 <- (7 * as.numeric(names(temp.6))) 

data.e.sparse.8 <- data.e.sparse %>% filter(abs(R - 0.8) <= 0.03)
table(data.e.sparse.8$grp)
temp.8 <- which.max(table(data.e.sparse.8$grp)) 
es.idx.8 <- (7 * as.numeric(names(temp.8))) 


### Dense Testing
d.data.all <- read.csv("Bees R dense testing-table.csv", header = TRUE, skip = 6)[-c(6,7,9)]
d.data.all$grp <- (floor((d.data.all$X.run.number.-1) / 20)) + 1
d.data <- d.data.all %>% filter(c1_mult > c2_mult)

## Divide data into groups d.num away from: R = 0.4, 0.6, 0.8
d.num <- 0.03
d.data.4 <- d.data %>% filter(abs(R - 0.4) <= d.num)
temp.4 <- which.max(table(d.data.4$grp)) 
table(d.data.4$grp)
d.idx.4 <- (20 * as.numeric(names(temp.4))) 
d.data.all[d.idx.4,] # Best sequence is d.data.all[3941:3960,]

d.data.6 <- d.data %>% filter(abs(R - 0.6) <= d.num)
temp.6 <- which.max(table(d.data.6$grp)) 
table(d.data.6$grp)
d.idx.6 <- 20 * as.numeric(names(temp.6))
d.data.all[d.idx.6,] # Best sequence is d.data.all[2221:2240,]

d.data.8 <- d.data %>% filter(abs(R - 0.8) <= d.num)
temp.8 <- which.max(table(d.data.8$grp)) 
table(d.data.8$grp)
d.idx.8 <- 20 * as.numeric(names(temp.8))
d.data.all[d.idx.8,] # Best sequence is d.data.all[821:840,]


### Sparse Testing
#s.data.all <- read.csv("Bees R sparse testing_10rep-table.csv", header = TRUE, skip = 6)[-c(6,7,9)]
#s.data.all <- read.csv("Bees R sparse testing_10rep_detailed-table.csv", header = TRUE, skip = 6)
s.data.all <- read.csv("Bees R sparse testing_1500_2-table.csv", header = TRUE, skip = 6)
s.data.all$grp <- (floor((s.data.all$X.run.number.-1) / 4)) + 1
s.data <- s.data.all %>% filter(c1_mult > c2_mult)
s.num <- 0.03

## Divide data into groups s.num away from: R = 0.4, 0.6, 0.8
s.data.4 <- s.data %>% filter(abs(R - 0.4) <= s.num)
temp.4 <- which.max(table(s.data.4$grp))
table(s.data.4$grp)
s.idx.4 <- (4 * as.numeric(names(temp.4))) 
s.data.all[s.idx.4,]

s.data.6 <- s.data %>% filter(abs(R - 0.6) <= s.num)
temp.6 <- which.max(table(s.data.6$grp)) 
table(s.data.6$grp)
s.idx.6 <- 4 * as.numeric(names(temp.6))
s.data.all[s.idx.6,]

s.data.8 <- s.data %>% filter(abs(R - 0.8) <= s.num)
temp.8 <- which.max(table(s.data.8$grp)) 
table(s.data.8$grp)
s.idx.8 <- 4 * as.numeric(names(temp.8))
s.data.all[s.idx.8,]
