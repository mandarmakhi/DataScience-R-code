#Prepare a prediction model for profit of 50_startups data.
#Do transformations for getting better predictions of profit and make a table containing R^2 value for each prepared model.

#Multi Linar regression

Startups<- read.csv("C:/Users/Mandar/Desktop/data/assignments/multi linear/50_Startups.csv")
 View(Startups)

summary(Startups)

cor(Startups[,-4])

boxplot(Startups)

pairs(Startups)

model <- lm(Startups$Profit~. , data = Startups)
summary(model)
#The R-Square value for the above model is 0.9508

plot(model)
install.packages("car")
library(car)

car::vif(model) #variation influence factor

residualPlots(model)

qqPlot(model)

influenceIndexPlot(model)
#Here we got observation number 49 and 50 as outliers so we will remove them

#Iteration 1
Startups <- Startups[c(-49,-50),]
#Now lets make another model

model1 <- lm(Startups$Profit~. , data = Startups)
summary(model1)
#The R-square value is 0.9628
car::vif(model1)
plot(model1)
residualPlots(model1)
qqPlot(model1)

#Iteration 2

Startups <- Startups[c(-15,-16),]
model2 <- lm(Startups$Profit~. , data = Startups)
summary(model2)
#The R-square value is 0.9712
car::vif(model2)
plot(model2)
residualPlots(model2)
qqPlot(model2)

#Iteration 3

Startups <- Startups[c(-46,-44,-37,-35),]
model3 <- lm(Startups$Profit~. , data = Startups)
summary(model3)
#The R-square value is 0.9767
car::vif(model3)
plot(model3)
residualPlots(model3)
qqPlot(model3)

r_square <- data.frame("R-square" = c(0.9508,0.9628, 0.9712, 0.9767))
r_square
