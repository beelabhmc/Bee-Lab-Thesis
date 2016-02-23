# Flower Characteristics Analyses
# Sam Woodman

library(dplyr)
setwd("~/Google Drive/Semester 8/Thesis/NetLogo+R GitHub/Flower Data ")

file.names <- c("Plant.ID", "Species.Name", "Date", "Flow.Diam.mm", "Cor.Len.mm", 
                "Florets", "Total.Vol.Nec.micro.L", "Vol.Flor.micro.L", "BRIX", 
                "Sugar.micro.g", "Sugar.Flor.micro.g", "Notes")
flower.char <- read.csv("Flower Characteristics.csv", header = TRUE, col.names = file.names)

quality <- flower.char %>%
  select(Plant.ID, Species.Name, Date, BRIX) %>% 
  filter(!is.na(as.numeric(BRIX)) & as.numeric(BRIX) > 0)
quality$BRIX <- as.numeric(quality$BRIX)
quality$log.BRIX <- log(quality$BRIX)

hist(quality$BRIX)
hist(quality$log.BRIX)
boxplot(BRIX~Species.Name, data=quality)

quantity <- flower.char %>%
  select(Plant.ID, Species.Name, Date, Vol.Flor.micro.L, Total.Vol.Nec.micro.L) %>% 
  filter(!is.na(Vol.Flor.micro.L) & Vol.Flor.micro.L > 0)

boxplot(Vol.Flor.micro.L~Species.Name, data=quantity)

#### lm-quality ####
par(mfrow=c(2,2))
lm.quality1 <- lm(BRIX~Species.Name, data = quality)
summary(lm.quality1)
plot(lm.quality1$residuals, main="Normal:Species")
plot(lm.quality1$residuals, main="Residuals from model assuming normal distribution", 
     ylab = "Residual", xlab = "Sample")

lm.quality2 <- lm(BRIX~Date, data = quality)
summary(lm.quality2)
plot(lm.quality2$residuals, main="Normal:Date")

lm.quality3 <- lm(BRIX~Species.Name+Date, data = quality)
summary(lm.quality3)
plot(lm.quality3$residuals, main="Normal:Species+Date")

#### glm-quality ####
quality.glm <- quality

# Poisson
par(mfrow=c(2,2))
glm.quality.p1 <- glm(BRIX~Species.Name, data = quality.glm, family = poisson())
plot(glm.quality.p1$residuals, main="Poisson:Species")

glm.quality.p2 <- glm(BRIX~Date, data = quality.glm, family = poisson())
plot(glm.quality.p2$residuals, main="Poisson:Date")

glm.quality.p3 <- glm(BRIX~Species.Name+Date, data = quality.glm, family = poisson())
plot(glm.quality.p3$residuals, main="Poisson:Species+Date")

# Gamma
par(mfrow=c(2,2))
glm.quality.g1 <- glm(BRIX~Species.Name, data = quality.glm, family = Gamma())
plot(glm.quality.g1$residuals, main="Gamma:Species")

glm.quality.g2 <- glm(BRIX~Date, data = quality.glm, family = Gamma())
plot(glm.quality.g2$residuals, main="Gamma:Date")

glm.quality.g3 <- glm(BRIX~Species.Name+Date, data = quality.glm, family = Gamma())
plot(glm.quality.g3$residuals, main="Gamma:Species+Date")

#### lm-quantity ####
par(mfrow=c(2,2))
lm.quantity1 <- lm(Vol.Flor.micro.L~Species.Name, data = quantity)
summary(lm.quantity1)
plot(lm.quantity1$residuals, main = "Normal:Species")

lm.quantity2 <- lm(Vol.Flor.micro.L~Date, data = quantity)
summary(lm.quality2)
plot(lm.quantity2$residuals, main = "Normal:Date")

lm.quantity3 <- lm(Vol.Flor.micro.L~Species.Name+Date, data = quantity)
summary(lm.quantity3)
plot(lm.quantity3$residuals, main = "Normal:Species+Date")

#### glm-quantity ####
# Poisson
par(mfrow=c(2,2))
glm.quantity.p1 <- glm(Vol.Flor.micro.L~Species.Name, data = quantity, family = poisson())
plot(glm.quantity.p1$residuals, main="Poisson:Species")

glm.quantity.p2 <- glm(Vol.Flor.micro.L~Date, data = quantity, family = poisson())
plot(glm.quantity.p2$residuals, main="Poisson:Date")

glm.quantity.p3 <- glm(Vol.Flor.micro.L~Species.Name+Date, data = quantity, family = poisson())
plot(glm.quantity.p3$residuals, main="Poisson:Species+Date")
plot(glm.quantity.p3$residuals, main="Residuals from model assuming poisson distribution", 
     ylab = "Residual", xlab = "Sample")

# Gamma
par(mfrow=c(2,2))
glm.quantity.g1 <- glm(Vol.Flor.micro.L~Species.Name, data = quantity, family = Gamma())
plot(glm.quantity.g1$residuals, main="Gamma:Species")

glm.quantity.g2 <- glm(Vol.Flor.micro.L~Date, data = quantity, family = Gamma())
plot(glm.quantity.g2$residuals, main="Gamma:Date")

glm.quantity.g3 <- glm(Vol.Flor.micro.L~Species.Name+Date, data = quantity, family = Gamma())
plot(glm.quantity.g3$residuals, main="Gamma:Species+Date")




# Pretty plots
par(mfrow=c(1,2))
plot(lm.quality1$residuals, main="Normal distribution", 
     ylab = "Residual", xlab = "Sample")
plot(glm.quantity.p3$residuals, main="Poisson distribution", 
     ylab = "Residual", xlab = "Sample")

par(mfrow=c(1,2))
boxplot(BRIX~Species.Name, data=quality, main = "Quality")
boxplot(Vol.Flor.micro.L~Species.Name, data=quantity, main = "Quantity")


