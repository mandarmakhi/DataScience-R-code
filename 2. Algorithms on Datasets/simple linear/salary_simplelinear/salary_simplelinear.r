# 4) Salary_hike -> Build a prediction model for Salary_hike

#Salary Hike

#import the dataset salary_Data.csv
Salary_Data <- read.csv("C:/Users/Mandar/Desktop/data/assignments/simple linear/salary_simplelinear/Salary_Data.csv")
attach(Salary_Data)   
View(Salary_Data)
head(Salary_Data)#it's show first few data
tail(Salary_Data)# it's show last few data
summary(Salary_Data)
  
#Gives Standard Deviation
sd(Salary_Data$YearsExperience)
sd(Salary_Data$Salary)

#Gives Variance
var(Salary_Data$YearsExperience)
var(Salary_Data$Salary)

cor(Salary_Data)#gives the Correlation Coefficient as a matrix
plot(Salary_Data)

#let's build a linear model
y <- lm(Salary_Data$Salary~., data = Salary_Data)
y
plot(y)
summary(y)

# The R-Square value is 0.957 with Residual Standard Error as 5788
#Data transformation & build diffrent models

#log transformation
log_model<-lm(log(Salary_Data$Salary)~.,data=Salary_Data)
log_model
summary(log_model)
plot(log_model)
#The R-square value as 0.932 with Residual Standard Error as 0.09789

#Squareroot Transformaton
sqrt_model<- lm(sqrt(Salary_Data$Salary)~., data=Salary_Data)
sqrt_model
summary(sqrt_model)
plot(sqrt_model)
#Here R-Square value is 0.931 with Residual Standard Error as 7399
