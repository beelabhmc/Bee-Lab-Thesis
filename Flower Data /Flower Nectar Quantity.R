# Flower Nectar Quantity
# Sam Woodman

library(dplyr)
setwd("~/Google Drive/Semester 8/Thesis/Flower Data")

file.names <- c("Plant.ID", "Species.Name", "Date", "Flow.Diam.mm", "Cor.Len.mm", 
                "Florets", "Total.Vol.Nec.micro.L", "Vol.Flor.micro.L", "BRIX", 
                "Sugar.micro.g", "Sugar.Flor.micro.g", "Notes")
flower.char <- read.csv("Flower Characteristics.csv", header = TRUE, col.names = file.names)
bfs.master <- read.csv("BFS Master Survey.csv", header = TRUE)