#Regression Modle and summary
model.car<-lm(MPG~.,data= Cars)
summary(model.car)

#Multi[le colinearity
install.packages("car")
library(car)
