################ARIMA#######################
aviation <- read.csv("C:/Users/Mandar/Desktop/data/csv files/Aviation.csv") # Aviation.csv
View(aviation)
aviation<-aviation


plot(train)
acf(train)
pacf(train)
a<-arima(train,order = c(1,1,8),method = "ML")


#Auto. Arima model on the price agg data
#install.packages("forecast")

library(forecast)
model_AA<-auto.arima(train)#use to get the accurate acf and pacf values
model_AA
pred_AA<-data.frame(forecast(model_AA))

acf(model_AA$residuals)#check the error in the acf model
pacf(model_AA$residuals)#check the error in the pacf model
windows()
plot(forecast(model_AA,h=12),xaxt="n")#plot the forcasted model
