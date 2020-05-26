# 3) Emp_data -> Build a prediction model for Churn_out_rate

#import the data set emp_data.csv
emp_data <- read.csv("C:/Users/Mandar/Desktop/data/assignments/simple linear/emp_simplelinear/emp_data.csv")
  View(emp_data)
  attach(emp_data)
  summary(emp_data)#Gives the Summary of the dataset

  sd(emp_data$Salary_hike)#Gives Standard Deviation
  var(emp_data$Churn_out_rate)#Gives Variance

  sd(emp_data$Churn_out_rate)
  var(emp_data$Salary_hike)
  
  plot(emp_data)

  
  #Lets build a Linear Model
  
model <- lm(emp_data$Churn_out_rate~., data = emp_data)
plot(model)
summary(model)#Gives the Summary of the model

#The P-value is less than 0.05 and the R-Squared value is 0.8312 with Residual Standard Error as 4.469


############################Lets do Data Transformation and build models##################################
 

#Log Transformation
log_model<-lm(log(emp_data$Churn_out_rate)~.,data=emp_data)
summary(log_model)
plot(log_model)
# we get R-Square value as 0.8735 and Residual Standard Error as 0.0519



#Squareroot Transformation
sqrt_model<-lm(sqrt(emp_data$Churn_out_rate)~.,data=emp_data)
summary(sqrt_model)
plot(sqrt_model)
#Here the R-Square value is 0.84 with Residual Standard Error as 4.351
