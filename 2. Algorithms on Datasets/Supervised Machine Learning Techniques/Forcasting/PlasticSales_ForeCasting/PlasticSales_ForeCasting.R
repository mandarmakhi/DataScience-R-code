#PlasticSales_ForeCasting 


#install.packages("readr")

library(readr)

plastic <- read.csv("C:/Users/Mandar/Desktop/data/assignments/Forcasting/PlasticSales.csv")
  View(plastic)
  attach(plastic)
  head(plastic)
  
  windows()
  plot(plastic$Sales,type="l")
 
  summary(plastic)
  
  sd(plastic$Sales) #standard deviation of sales
  
  var(plastic$Sales) #variance of sales
  
#Create dummy variables for 12 months
  X<- data.frame(outer(rep(month.abb,length = 60), month.abb,"==") + 0 )# Create dummies for 12 months
  View(x)

#Assigns the Column names As MonthAbbreviations
  colnames(X) <- month.abb 
  View(X)  

#Make a new dataframe with Original data and Dummy Variables
  new_data <- cbind(plastic, X) 
  View(new_data)
  
#Add a new column t which will have a sequence of numbers from 1 to 96
  new_data["t"]<- 1:60
  View(new_data)
  
#Add a column which will have the Square values of t column
  new_data["t_square"] <- new_data["t"] * new_data["t"]
  View(new_data)
  
#Add One more column that has the log values of the Passenger values
  new_data["log_sales"] <- log(new_data["Sales"])
  View(new_data)
  
  attach(new_data)
  
  
#Divide the data into Train and Test data
  train <- new_data[1:36,]
  test <- new_data[37:60,]

  
#Build the Different Models and Compute their RMSE Values
  
####################################[1] Linear Regression Model####################################
  
  lin_mod <- lm(Sales~t , data = train) #Here we are building a linear model for Sales using the train data
  summary(lin_mod)
  
  lin_pred <- data.frame(predict(lin_mod, interval = "predict", newdata = test)) #Here we are pedicting the values for test set
  View(lin_pred)
  
  #Lets find the RMSE value for Linear Model
  rmse_lin_model <- sqrt(mean((test$Sales - lin_pred$fit)^2, na.rm = T))
  rmse_lin_model

####################################[2] Exponential Model####################################  

  exp_mod <- lm(log_sales~t, data = train) #Here we are Building a Exponential Model
  summary(exp_mod)
  
  exp_pred <- data.frame(predict(exp_mod, interval = "predict", newdata = test))
  View(exp_pred)
  
  #Lets find the RMSE value
  rmse_exp_mod <- sqrt(mean((test$Sales - exp(exp_pred$fit))^2, na.rm = T))
  rmse_exp_mod
  
####################################[3] Quadratic Model####################################   
  
  Quad_model<-lm(Sales~t+t_square,data=train)
  summary(Quad_model)
  
  Quad_pred<-data.frame(predict(Quad_model,interval='predict',newdata=test))
  View(Quad_pred)
  
  #Lets find the RMSE value
  rmse_Quad<-sqrt(mean((test$Sales-Quad_pred$fit)^2,na.rm=T))
  rmse_Quad
 
####################################[4] Additive Seasonality model####################################   
  
  sea_add_model<-lm(Sales~Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data=train)
  summary(sea_add_model)
  
  sea_add_pred<-data.frame(predict(sea_add_model,newdata=test,interval='predict'))
  View(sea_add_pred)
  
  #Lets find the RMSE value
  rmse_sea_add<-sqrt(mean((test$Sales-sea_add_pred$fit)^2,na.rm = T))
  rmse_sea_add
  
####################################[5] Additive Seasonality with Linear Regression model####################################    
   
  Add_sea_Linear_model<-lm(Sales~t+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data=train)
  summary(Add_sea_Linear_model)
  
  Add_sea_Linear_pred<-data.frame(predict(Add_sea_Linear_model,interval='predict',newdata=test))
  View(Add_sea_Linear_pred)
  
  #Lets find the RMSE value
  rmse_Add_sea_Linear<-sqrt(mean((test$Sales-Add_sea_Linear_pred$fit)^2,na.rm=T))
  rmse_Add_sea_Linear

####################################[6] Additive Seasonality with Quadratic model####################################     

  Add_sea_Quad_model<-lm(Sales~t+t_square+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data=train)
  summary(Add_sea_Quad_model)
  
  Add_sea_Quad_pred<-data.frame(predict(Add_sea_Quad_model,interval='predict',newdata=test))
  View(Add_sea_Quad_pred)
  
  #Lets find the RMSE value
  rmse_Add_sea_Quad<-sqrt(mean((test$Sales-Add_sea_Quad_pred$fit)^2,na.rm=T))
  rmse_Add_sea_Quad
  
####################################[7] Multiplicative Seasonality Model####################################   
  
  multi_sea_model<-lm(log_sales~Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data = train)
  summary(multi_sea_model)
  
  multi_sea_pred<-data.frame(predict(multi_sea_model,newdata=test,interval='predict'))
  View(multi_sea_pred)
  
  #Lets find the RMSE value
  rmse_multi_sea<-sqrt(mean((test$Sales-exp(multi_sea_pred$fit))^2,na.rm = T))
  rmse_multi_sea
 
####################################[8] Multiplicative Seasonality with Linear regression Model####################################    
  
  multi_sea_lin_model<-lm(log_sales~t+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data = train)
  summary(multi_sea_lin_model) 
  
  multi_sea_lin_pred<-data.frame(predict(multi_sea_lin_model,newdata=test,interval='predict'))
  View(multi_sea_lin_pred)
  
  #Lets find the RMSE value
  rmse_multi_sea_lin<-sqrt(mean((test$Sales-exp(multi_sea_lin_pred$fit))^2,na.rm = T))
  rmse_multi_sea_lin  

  
# make a Table for the Models and its RMSE value
  table_rmse<-data.frame('Model'=c("Linear Regression Model","Exponential Model","Quadratic Model","Additive Seasonality model","Additive Seasonality with Linear Regression model","Additive Seasonality with Quadratic model","Multiplicative Seasonality Model","Multiplicative Seasonality with Linear regression Model"),'RMSE'=c(rmse_lin_model,rmse_exp_mod,rmse_Quad,rmse_sea_add,rmse_Add_sea_Linear,rmse_Add_sea_Quad,rmse_multi_sea,rmse_multi_sea_lin))
  View(table_rmse)
  colnames(table_rmse)<-c("model","RMSE")
  View(table_rmse)
  
  
  Add_sea_Linear_model_whole<-lm(Sales~t+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data=new_data)
  
  #Lets get the Residuals
  resid <- residuals(Add_sea_Linear_model_whole)
  resid[1:10]
  
  windows()
  hist(resid)
  
  windows()
  acf(resid,lag.max = 10)
  
  #arima model
  k <- arima(resid, order=c(2,0,0))
  
  windows()
  acf(k$residuals,lag.max = 15)
  
  pred_res<- predict(arima(resid,order=c(2,0,0)),n.ahead = 60)
  str(pred_res)
  
  pred_res$pred
  acf(k$residuals)
  
######################Lets Build a ARIMA model for whole dataset. ARIMA ###############################
  
 
  
  library(tseries)
  library(forecast)
  
#Lets convert the data into Time Series data 
  
  plastic_ts <- ts(plastic$Sales, frequency = 12, start = c(1949)) #Create a Time Series data
  View(plastic_ts)
  plot(plastic_ts) 
  
  
  pacf(plastic_ts) #Lets Consider it as 1
  
  #Lets Find the q-value by acf
  acf(plastic_ts) #Lets Consider this as 0
  
 
  #now lets build an ARIMA model
  a <- arima(plastic_ts, order = c(1,1,0), method = "ML")
  a
  
  #Lets plot the forecast using the ARIMA model
  plot(forecast(a,h=5), xaxt = "n")
  
  #Seeing the plot, we get to know that the graph was going down.
  
  ab <- auto.arima(plastic_ts)
  
  windows()
  plot(forecast(ab, h=5), xaxt = "n")
  
  
  #So now we can see that the forecast was accurate 
  prediction <- forecast(ab, h=12)
  prediction  
  
##############################This will predict Data for the Next 12 Months##############################
  
  
    