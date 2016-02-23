# Flower Nectar Quantity
# Sam Woodman

library(dplyr)
setwd("~/Google Drive/Semester 8/Thesis/NetLogo+R GitHub/Flower Data ")

file.names <- c("Plant.ID", "Species.Name", "Date", "Flow.Diam.mm", "Cor.Len.mm", 
                "Florets", "Total.Vol.Nec.micro.L", "Vol.Flor.micro.L", "BRIX", 
                "Sugar.micro.g", "Sugar.Flor.micro.g", "Notes")
flower.char <- read.csv("Flower Characteristics.csv", header = TRUE, col.names = file.names)
bfs.data <- read.csv("BFS Master Survey.csv", header = TRUE)
bfs.data <- bfs.data %>% 
  filter(as.Date(Date, format = "%m/%d/%Y") > 
           as.Date("03/04/2015", format = "%m/%d/%Y")) %>% 
  select(Date, Species.Name, X.Flowers)

# Correct pre-identified species names
flower.char$Species.Name <- gsub("Sambuccua nigra", "Sambucus nigra", flower.char$Species.Name)
flower.char$Species.Name <- gsub("Sambuccus nigra", "Sambucus nigra", flower.char$Species.Name)
species.names.bfs <- sort(unique(as.character(flower.char$Species.Name)))

bfs.data$Species.Name <- gsub("Ericamaria pinifolia", "Ericameria pinifolia", bfs.data$Species.Name)
bfs.data$Species.Name <- gsub("Sambuccus nigra", "Sambucus nigra", bfs.data$Species.Name)
species.names.all <- sort(unique(as.character(bfs.data$Species.Name)))

bfs.data <- filter(bfs.data, bfs.data$Species.Name %in% species.names.bfs)

avg.vol <- sapply(species.names.bfs, function(i) mean(bfs.data[bfs.data$Species.Name == i,]$X.Flowers, na.rm = TRUE))
# The averages