# 2) Delivery_time -> Predict delivery time using sorting time 


#import the data set delivery_time.csv
delivery_time <- read.csv("C:/Users/Mandar/Desktop/data/assignments/simple linear/delivery_SimpleLinearRegression/delivery_time.csv")
   View(delivery_time)
   attach(delivery_time)
   head(delivery_time)
   tail(delivery_time)
   summary(delivery_time) #Gives the Summary

sd(delivery_time$Delivery.Time)#Standard Deviation
var(delivery_time$Delivery.Time)#Variance

sd(delivery_time$Sorting.Time)
var(delivery_time$Sorting.Time)

cor(delivery_time)


#Lets build a Linear Model on the data
y <- lm(delivery_time$Delivery.Time~., data = delivery_time)

plot(delivery_time)
plot(y)
summary(y)
# we can see the R-Squared value is 0.6823 and the P-value is less than 0.05

#Lets increase the R-Square value by data Transformation
#Squareroot Transformation
sqrt_model<-lm(sqrt(delivery_time$Delivery.Time)~.,delivery_time)
summary(sqrt_model)
#Here we got the R-sqaure value as 0.6958 with Residual Standard Error as 2.872


#Log Transformation
log_model<-lm(log(delivery_time$Delivery.Time)~.,data=delivery_time)
summary(log_model)
#Here we get R-Squared value as 0.7109 and Residual Standard Error as 0.1755 






#Inorder to find the points that affect the model, use library mvinfluence

#install.packages("mvinfluence")

library(mvinfluence)

influenceIndexPlot(model)


#Using the plots we can see that the points 5,9,21,19 are causing problems, lets remove these points and build the model
delivery01 <- delivery_time[c(-5,-9,-21),]

#Lets Build a linear Model on the new data
y1 <- lm(delivery01$Delivery.Time~., data = delivery01)
plot(y1)
summary(y1)
#Now we got the R-Squarred value as 0.8332 which means this will give the output 83.32% time correct
#with Residual Standard Error as 1.839