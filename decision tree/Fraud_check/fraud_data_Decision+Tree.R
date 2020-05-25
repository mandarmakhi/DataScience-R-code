#Decision Tree

#Use decision trees to prepare a model on fraud data 
#treating those who have taxable_income <= 30000 as "Risky" and others are "Good"
#install.packages("gmodels")
#install.packages("party")
library(party)
library(gmodels)
library(ggplot2)
library(dplyr)
library(caret)
library(C50)

#Lets Import the Data
Fraud<- read.csv("C:/Users/Mandar/Desktop/data/assignments/decision tree/Fraud_check/Fraud_check.csv")
  View(Fraud)
  head(Fraud)

  dim(Fraud) 

  
str(Fraud) #Gives the Entire Structure of the dataset
 
#Lets first convert the Categorical columns into Factors

Fraud$Undergrad <- as.factor(Fraud$Undergrad)
Fraud$Marital.Status <- as.factor(Fraud$Marital.Status)
Fraud$Urban <- as.factor(Fraud$Urban)


summary(Fraud)

#Standard Deviation & #Variance
sd(Fraud$Taxable.Income)
var(Fraud$Taxable.Income)
sd(Fraud$City.Population)
var(Fraud$City.Population)
sd(Fraud$Work.Experience)
var(Fraud$Work.Experience)


cor(Fraud) #Returns the Correlation Matrix 


#Here we have to Build a classification Tree


#I will use the If else condition to convert the data into Binomial
risk <- ifelse(Fraud$Taxable.Income <= 30000, "Risky","Good")
risk <- as.factor(risk)
Fraud1 <- cbind(Fraud[,-3],risk) 

#Divide the data into Train and Test Data with 70% partion

intraininglocal <- createDataPartition(Fraud1$risk, p=.70, list = F) 
train <- Fraud1[intraininglocal,]
test <- Fraud1[-intraininglocal,]


tree <- C5.0(risk~. ,data = train)#Now Build the Decision Tree

#Predict for test data

pred<- predict.C5.0(mtree,newdata = test[,-7])
a<- table(test$risk,pred) 
sum(diag(a))/sum(a) #to find the Accuracy of the Model. 

CrossTable(test$risk,pred)

#Lets Plot the Model
plot(tree)

#Lets see the Summary of the Model
summary(tree)

#Lets build a model for whole data
model <- ctree(risk~. ,Fraud1)
summary(model)
plot(model)

pred1 <- predict(model)
CrossTable(risk,pred1)

#We can also Include Boosting in Bagging Technique

#We use For loop for bagging in order to make multiple models

acc<- c()
for (i in 1:100) #This will create 500 different models
{
  print(i)
  
  intraininglocal <- createDataPartition(Fraud1$risk, p=.70, list = F) 
  train <- Fraud1[intraininglocal,]
  test <- Fraud1[-intraininglocal,]
  
  #Build  a Model
  fittree <- C5.0(train$risk~. , data = train, trials = 25)
  
  pred2<- predict.C5.0(fittree,test[,-7])
  a<- table(test$risk, pred2)
  
  #To save the Accuracy of the models
  acc<- c(acc,sum(diag(a))/sum(a)) 
}

summary(acc)
plot(acc)

summary(fittree)
