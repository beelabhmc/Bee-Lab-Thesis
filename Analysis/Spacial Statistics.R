## R spatial statistics
r.data <- read.csv("Bees R testing-table.csv", header = TRUE, skip = 6)[,c(2,3,4,5,8)]

r.data <- r.data %>% filter(c1_mult >= c2_mult)
r.data.dense <- filter(r.data, r.data$resource_density == "\"dense\"")
r.data.dense.r <- r.data.dense$R
r.data.sparse <- filter(r.data, r.data$resource_density == "\"sparse\"")
r.data.sparse.r <- r.data.sparse$R