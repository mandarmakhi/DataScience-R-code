#Forecasting Model


library(xlsx)
Airlines <- read_excel("C:/Users/Mandar/Desktop/data/assignments/Forcasting/Airlines+Data.xlsx",sheet = "Sheet1")
 View(Airlines)
head(Airlines) 
attach(Airlines)

summary(Airlines)

sd(Passengers)#standard deviation of passengers column

var(Passengers)#variance of passengers column

plot(Airlines, type="h")#we plot the airline data

names(Airlines)

#we can create dummy varibles for 120 months

X<-data.frame(outer(rep(month.abb,length=96),month.abb,"==")+0)
View(X)


#Assigns the Column names As MonthAbbreviations

colnames(X)<- month.abb

View(X)

#we can make new datafeame with original data and dummy variables

New_data<-cbind(Airlines,X)
View(New_data)

#lets add a new column "t" which will have a sequence of number from 1 to 96
New_data["t"]<-1:96
View(New_data)

#lets add a column which will have the square value of "t" column
New_data["t_square"]<- New_data["t"]*New_data["t"]
View(New_data)

#lets add one more column log value if the passenger values
New_data["log_passenger"]<-log(New_data["Passengers"])
View(New_data)

attach(New_data)
names(New_data)

#we can divide data into the test & train data
train<-New_data[1:72,]
test<-New_data[73:93,]

#lets build different model & compute RMSE values

##############[1] Linear Regression Model #####################

li_mod <- lm(Passengers~t, data=train)#building a linear model for passenger
summary(li_mod)

li_pred<-data.frame(predict(li_mod, interval = "predict",newdata = test))
View(li_pred)

#lets find the RMSE value for linear model
rmse_li_mod <- sqrt(mean((test$Passengers - li_pred$fit)^2, na.rm = T))
rmse_li_mod

##############[2] Exponential Model #####################

exp_mod <- lm(log_passenger~t, data = train) #Here we are Building a Exponential Model
summary(exp_mod)
exp_pred <- data.frame(predict(exp_mod, interval = "predict", newdata = test))
View(exp_pred)
#Lets find the RMSE value
rmse_exp_mod <- sqrt(mean((test$Passengers - exp(exp_pred$fit))^2, na.rm = T))
rmse_exp_mod

##############[3] Quadratic Model #####################
 
Quad_model<-lm(Passengers~t+t_square,data=train)
summary(Quad_model)
Quad_pred<-data.frame(predict(Quad_model,interval='predict',newdata=test))
rmse_Quad<-sqrt(mean((test$Passengers-Quad_pred$fit)^2,na.rm=T))
rmse_Quad

##############[4] Additive Seasonality model #####################

sea_add_model<-lm(Passengers~Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data=train)
summary(sea_add_model)
sea_add_pred<-data.frame(predict(sea_add_model,newdata=test,interval='predict'))
rmse_sea_add<-sqrt(mean((test$Passengers-sea_add_pred$fit)^2,na.rm = T))
rmse_sea_add


##############[5] Additive Seasonality with Linear Regression model #####################

Add_sea_Linear_model<-lm(Passengers~t+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data=train)
summary(Add_sea_Linear_model)
Add_sea_Linear_pred<-data.frame(predict(Add_sea_Linear_model,interval='predict',newdata=test))
rmse_Add_sea_Linear<-sqrt(mean((test$Passengers-Add_sea_Linear_pred$fit)^2,na.rm=T))
rmse_Add_sea_Linear

##############[6]  Additive Seasonality with Quadratic model #####################

Add_sea_Quad_model<-lm(Passengers~t+t_square+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data=train)
summary(Add_sea_Quad_model)
Add_sea_Quad_pred<-data.frame(predict(Add_sea_Quad_model,interval='predict',newdata=test))
rmse_Add_sea_Quad<-sqrt(mean((test$Passengers-Add_sea_Quad_pred$fit)^2,na.rm=T))
rmse_Add_sea_Quad

##############[7]  Multiplicative Seasonality Model #####################


multi_sea_model<-lm(log_passenger~Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data = train)
summary(multi_sea_model)
multi_sea_pred<-data.frame(predict(multi_sea_model,newdata=test,interval='predict'))
rmse_multi_sea<-sqrt(mean((test$Passengers-exp(multi_sea_pred$fit))^2,na.rm = T))
rmse_multi_sea

##############[8] Multiplicative Seasonality with Linear regression Model #####################
 
multi_sea_lin_model<-lm(log_passenger~t+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data = train)
summary(multi_sea_lin_model) 
multi_sea_lin_pred<-data.frame(predict(multi_sea_lin_model,newdata=test,interval='predict'))
rmse_multi_sea_lin<-sqrt(mean((test$Passengers-exp(multi_sea_lin_pred$fit))^2,na.rm = T))
rmse_multi_sea_lin


#Lets make a Table for the Models and its RMSE value
table_rmse<-data.frame('Model'=c("Linear Regression Model","Exponential Model","Quadratic Model","Additive Seasonality model","Additive Seasonality with Linear Regression model","Additive Seasonality with Quadratic model","Multiplicative Seasonality Model","Multiplicative Seasonality with Linear regression Model"),'RMSE'=c(rmse_li_mod,rmse_exp_mod,rmse_Quad,rmse_sea_add,rmse_Add_sea_Linear,rmse_Add_sea_Quad,rmse_multi_sea,rmse_multi_sea_lin))
View(table_rmse)
colnames(table_rmse)<-c("model","RMSE")
View(table_rmse)


multi_sea_lin_model_whole <- lm(log_passenger~t+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov, data = New_data)

#Lets get the Residuals
resid <- residuals(multi_sea_lin_model_whole)
resid[1:10]

windows()
hist(resid)

windows()
acf(resid,lag.max = 10)

k <- arima(resid, order=c(6,0,0))

windows()
acf(k$residuals,lag.max = 15)
pred_res<- predict(arima(resid,order=c(1,0,0)),n.ahead = 120)
str(pred_res)
pred_res$pred
acf(k$residuals)

#Lets Build a ARIMA model for whole dataset. ARIMA

#Lets convert the data into Time Series data

library(tseries)
library(forecast)

#Create a Time Series data

airline_ts <- ts(Airlines$Passengers, frequency = 12, start = c(1995)) 
View(airline_ts)
plot(airline_ts) #Plots the data into a Line chart By default as the data is a Time Series Data


pacf(airline_ts) #Lets Consider it as 1

#Lets Find the q-value by acf
acf(airline_ts) #Lets Consider this as 1


#now lets build an ARIMA model
a <- arima(airline_ts, order = c(1,1,1), method = "ML")
a


#Lets plot the forecast using the ARIMA model
plot(forecast(a,h=5), xaxt = "n")



ab <- auto.arima(airline_ts)

windows()
plot(forecast(ab, h=12), xaxt = "n")
#  we can see that the forecast was accurate 

