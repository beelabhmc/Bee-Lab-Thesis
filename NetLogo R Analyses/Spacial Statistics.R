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
d.data <- read.csv("Bees R dense testing-table.csv", header = TRUE, skip = 6)[-c(6,7,9)]

## Divide data into groups .01 away from: R = 0.4, 0.6, 0.8
d.data.4 <- d.data %>% filter(abs(R - 0.4) <= 0.01)
temp.4 <- which.max(table(floor(d.data.4$X.run.number./20))) # Best sequence is d.data[2740:2759,]
d.idx.4 <- 20 * as.numeric(names(temp.4))
d.data[2740,]

d.data.6 <- d.data %>% filter(abs(R - 0.6) <= 0.01)
temp.6 <- which.max(table(floor(d.data.6$X.run.number./20))) # Best sequence is d.data[280:299,] alt: d.data[300:319,]
d.idx.6 <- 20 * as.numeric(names(temp.6))
d.data[280,]

d.data.8 <- d.data %>% filter(abs(R - 0.8) <= 0.01)
temp.8 <- which.max(table(floor(d.data.8$X.run.number./20))) # Best sequence is d.data[780:799,] alt: d.data[820:839,]
d.idx.8 <- 20 * as.numeric(names(temp.8))
d.data[780,]


### Sparse Testing
#s.data <- read.csv("Bees R sparse testing-table.csv", header = TRUE, skip = 6)[-c(6,7,9)]

## Divide data into groups .01 away from: R = 0.4, 0.6, 0.8 and get parameters
s.data.4 <- s.data %>% filter(abs(R - 0.4) <= 0.01)
temp.4 <- which.max(table(floor(s.data.4$X.run.number./10))) # Best sequence is d.data[,]
s.idx.4 <- 10 * as.numeric(names(temp.4))
d.data[,]

s.data.6 <- d.data %>% filter(abs(R - 0.6) <= 0.01)
temp.6 <- which.max(table(floor(s.data.6$X.run.number./10))) # Best sequence is d.data[,]
s.idx.6 <- 10 * as.numeric(names(temp.6))
d.data[,]

s.data.8 <- d.data %>% filter(abs(R - 0.8) <= 0.01)
temp.8 <- which.max(table(floor(s.data.8$X.run.number./10))) # Best sequence is d.data[,]
s.idx.8 <- 10 * as.numeric(names(temp.8))
d.data[,]