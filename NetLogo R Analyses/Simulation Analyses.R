# Sam Woodman
# Simulation Analyses for dense and sparse runs

library(dplyr)
setwd("~/Google Drive/Semester 8/Thesis/NetLogo+R GitHub/BehaviorSpace Data/Colony Simulations/")

## Dense simulation runs
dense.data <- read.csv("Bees sim_dense-table.csv", header = TRUE, skip = 6)[c(1:6,14,15,17:20,23:28)]
dense.data$communication. <- as.factor(dense.data$communication.)
dense.data$population <- as.factor(dense.data$population)

# Plot results
boxplot(nectar.mL..bee ~ communication.+population+R_value, data=dense.data, ylab = "Nectar(mL)/bee", xlab = "Parameters", 
        names = c("0.4_F_500", "0.4_T_500", "0.4_F_3000", "0.4_T_3000",
                  "0.6_F_500", "0.6_T_500", "0.6_F_3000", "0.6_T_3000",
                  "0.8_F_500", "0.8_T_500", "0.8_F_3000", "0.8_T_3000",
                  "1.0_F_500", "1.0_T_500", "1.0_F_3000", "1.0_T_3000"))
