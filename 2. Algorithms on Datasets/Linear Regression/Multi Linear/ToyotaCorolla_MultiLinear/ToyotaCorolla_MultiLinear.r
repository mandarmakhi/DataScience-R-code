#Multi Linear Regression

#We are using the Corolla.csv File

#We have to Prepare a model to predict the Price of the Car
#The Price are in Euro's

ToyotaCorolla <- read.csv("C:/Users/Mandar/Desktop/data/assignments/multi linear/ToyotaCorolla.csv")
 View(ToyotaCorolla)

 ToyotaCorolla <- data.frame(cbind(ToyotaCorolla$Price,ToyotaCorolla$Age_08_04,ToyotaCorolla$KM,ToyotaCorolla$HP,ToyotaCorolla$cc, ToyotaCorolla$Doors, ToyotaCorolla$Gears,ToyotaCorolla$Quarterly_Tax,ToyotaCorolla$Weight))
colnames(ToyotaCorolla) <- c("Price","Age_08_04","KM","HP","cc","Doors","Gears","Quarterly_Tax","Weight")

summary(ToyotaCorolla)

#Lets build a predicting model

corolla_model <- lm(ToyotaCorolla$Price~. , data = ToyotaCorolla)
summary(corolla_model)

#We have created a Multi Linear Regression Model to find the Price of the Vehicle and its R-Square value is 0.8638 which means that this model will give 86.38% times right answer.

#Lets Predict the Values for the Data of the Dataset

pred <- predict(corolla_model)
pred

final_data<- data.frame(ToyotaCorolla$Price, pred, Error = corolla_model$residuals)
view(final_data)

#As we could see that the Actual Price and Predicted Price has much difference, we will Build Another Data By Normalizing It

corolla_norm <- data.frame(scale(ToyotaCorolla))

#Now lets build a model Using the Scaled Values
corolla_norm_model <- lm(corolla_norm$Price~., data = corolla_norm)
summary(corolla_norm_model)

pred_norm <- predict(corolla_norm_model)
norm_data <- data.frame(corolla_norm$Price, pred_norm, corolla_norm_model$residuals)
norm_data

#Log  Transformation

corolla_log_model<- lm(log(ToyotaCorolla$Price)~. , data = ToyotaCorolla)
summary(corolla_log_model)
pred_log <- predict(corolla_log_model)
data.frame(log(ToyotaCorolla$Price), pred_log, corolla_log_model$residuals)
