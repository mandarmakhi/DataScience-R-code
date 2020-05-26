#Forecasting Model

#CocaCola Sales

#install.packages("xlsx")
library(xlsx)


coca <- read_excel("C:/Users/Mandar/Desktop/data/assignments/Forcasting/CocaCola_Sales_Rawdata.xlsx", sheet = "Sheet1")
View(coca)
attach(coca)
head(coca)


summary(coca)

sd(Sales) #Standard Deviation of sales column

var(Sales) #Variance of sales column

#Lets do a line Plot of the data
plot(Sales, type = "h") 

#Lets create Dummy Variables for 4 Quarters

coca["Qs"] <- rep(1:4, len=42)
coca[paste0('Q', 1:4)] <- model.matrix(~ factor(coca$Qs)-1)

#change the column names 
colnames(coca$`df1$dummy_cols1`,coca$`df1$dummy_cols2`, coca$`df1$dummy_cols3`, coca$`df1$dummy_cols4`) <- c("Q1","Q2","Q3","Q4")

#add a new column "t" which will have a sequence of numbers from 1 to 42
coca["t"]<- 1:42
View(coca)

#Add a column which will have the Square values of "t" column
coca["t_square"] <- coca["t"] * coca["t"]
View(coca)

#add One more column that has the log values of the Sales values
coca["log_sales"] <- log(coca["Sales"])
View(coca)



attach(coca) #We use attach function so that we can directly use the column name without using the dataset name

# Divide the data into Train and Test data

train <- coca[1:28,]
test <- coca[29:42,]

#Lets Build Different Models and Compute their RMSE Values

#########################################1. Linear Regression Model #########################################

lin_mod <- lm(Sales~t , data = train) #Here we are building a linear model for Sales using the train data
summary(lin_mod)

lin_pred <- data.frame(predict(lin_mod, interval = "predict", newdata = test)) #Here we are pedicting the values for test set
View(lin_pred)

#Lets find the RMSE value for Linear Model
rmse_lin_model <- sqrt(mean((test$Sales - lin_pred$fit)^2, na.rm = T))
rmse_lin_model


#########################################2. Exponential Model#########################################

exp_mod <- lm(log_sales~t, data = train) #Here we are Building a Exponential Model
summary(exp_mod)

exp_pred <- data.frame(predict(exp_mod, interval = "predict", newdata = test))
View(exp_pred)

#Lets find the RMSE value
rmse_exp_mod <- sqrt(mean((test$Sales - exp(exp_pred$fit))^2, na.rm = T))
rmse_exp_mod


#########################################3. Quadratic Model#########################################

Quad_model<-lm(Sales~t+t_square,data=train)
summary(Quad_model)

Quad_pred<-data.frame(predict(Quad_model,interval='predict',newdata=test))
View(Quad_pred)

#Lets find the RMSE value
rmse_Quad<-sqrt(mean((test$Sales-Quad_pred$fit)^2,na.rm=T))
rmse_Quad

#########################################4. Additive Seasonality model#########################################

sea_add_model<-lm(Sales~Q1+Q2+Q3,data=train)
summary(sea_add_model)

sea_add_pred<-data.frame(predict(sea_add_model,newdata=test,interval='predict'))
View(sea_add_pred)

#Lets find the RMSE value
rmse_sea_add<-sqrt(mean((test$Sales-sea_add_pred$fit)^2,na.rm = T))
rmse_sea_add


#########################################5. Additive Seasonality with Linear Regression model#########################################

Add_sea_Linear_model<-lm(Sales~t+Q1+Q2+Q3,data=train)
summary(Add_sea_Linear_model)

Add_sea_Linear_pred<-data.frame(predict(Add_sea_Linear_model,interval='predict',newdata=test))
View(Add_sea_Linear_pred)

#Lets find the RMSE value
rmse_Add_sea_Linear<-sqrt(mean((test$Sales-Add_sea_Linear_pred$fit)^2,na.rm=T))
rmse_Add_sea_Linear

#########################################6. Additive Seasonality with Quadratic model#########################################

Add_sea_Quad_model<-lm(Sales~t+t_square+Q1+Q2+Q3,data=train)
summary(Add_sea_Quad_model)

Add_sea_Quad_pred<-data.frame(predict(Add_sea_Quad_model,interval='predict',newdata=test))
View(Add_sea_Quad_pred)

#Lets find the RMSE value
rmse_Add_sea_Quad<-sqrt(mean((test$Sales-Add_sea_Quad_pred$fit)^2,na.rm=T))
rmse_Add_sea_Quad

#########################################7. Multiplicative Seasonality Model#########################################

multi_sea_model<-lm(log_sales~Q1+Q2+Q3,data = train)
summary(multi_sea_model)

multi_sea_pred<-data.frame(predict(multi_sea_model,newdata=test,interval='predict'))
View(multi_sea_pred)

#Lets find the RMSE value
rmse_multi_sea<-sqrt(mean((test$Sales-exp(multi_sea_pred$fit))^2,na.rm = T))
rmse_multi_sea

#########################################8. Multiplicative Seasonality with Linear regression Model#########################################

multi_sea_lin_model<-lm(log_sales~t+Q1+Q2+Q3,data = train)
summary(multi_sea_lin_model)

multi_sea_lin_pred<-data.frame(predict(multi_sea_lin_model,newdata=test,interval='predict'))
View(multi_sea_lin_pred)

#Lets find the RMSE value
rmse_multi_sea_lin<-sqrt(mean((test$Sales-exp(multi_sea_lin_pred$fit))^2,na.rm = T))
rmse_multi_sea_lin


#Lets make a Table for the Models and its RMSE value
table_rmse<-data.frame('Model'=c("Linear Regression Model","Exponential Model","Quadratic Model","Additive Seasonality model","Additive Seasonality with Linear Regression model","Additive Seasonality with Quadratic model","Multiplicative Seasonality Model","Multiplicative Seasonality with Linear regression Model"),'RMSE'=c(rmse_lin_model,rmse_exp_mod,rmse_Quad,rmse_sea_add,rmse_Add_sea_Linear,rmse_Add_sea_Quad,rmse_multi_sea,rmse_multi_sea_lin))
View(table_rmse)
colnames(table_rmse)<-c("model","RMSE")
View(table_rmse)


multi_sea_lin_model_whole <- lm(log_sales~t+Q1+Q2+Q3, data = coca)

#Lets get the Residuals
resid <- residuals(multi_sea_lin_model_whole)
resid[1:10]

windows()
hist(resid)

windows()
acf(resid,lag.max = 10)


k <- arima(resid, order=c(2,0,0))

windows()
acf(k$residuals,lag.max = 15)

pred_res<- predict(arima(resid,order=c(2,0,0)),n.ahead = 120)
str(pred_res)
pred_res$pred
acf(k$residuals)

#Lets Build a ARIMA model for whole dataset. ARIMA


library(tseries)
library(forecast)

#Lets convert the data into Time Series data

coca_ts <- ts(coca$Sales, frequency = 4, start = c(1986)) #Create a Time Series data
View(coca_ts)
plot(coca_ts) #Plots the data into a Line chart By default as the data is a Time Series Data


pacf(coca_ts) 

#Lets Find the q-value by acf
acf(coca_ts) 


#now lets build an ARIMA model
a <- arima(coca_ts, order = c(1,1,2), method = "ML")
a

#Lets plot the forecast using the ARIMA model
plot(forecast(a,h=5), xaxt = "n")



ab <- auto.arima(coca_ts)

windows()
plot(forecast(ab, h=5), xaxt = "n")

#So now we can see that the forecast was accurate 
prediction <- forecast(ab,h=4) #This will Predict for the next 4 Quarters
prediction
