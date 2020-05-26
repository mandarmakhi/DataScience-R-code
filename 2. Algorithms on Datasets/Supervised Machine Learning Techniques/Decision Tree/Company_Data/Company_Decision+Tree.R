#Decision Tree

#A cloth manufacturing company is interested to know about the segment or attributes causes high sale. 

#install.packages("caret")
#install.packages("C50")

library(C50)
library(factoextra)
library(caret)
library(gmodels)

#Lets Import the Dataset
company <- read.csv("C:/Users/Mandar/Desktop/data/assignments/decision tree/Company_Data/Company_Data.csv")
 View(company)
attach(company)
 head(company)
summary(company) #Gives the Summary of the Dataset

str(company) #Gives the Structure of the Dataset



ShelveLoc <- as.factor(ShelveLoc)
Urban <- as.factor(Urban)
US <- as.factor(US)



High <- ifelse(Sales > 8,"Yes","No")
High <- as.factor(High)

#Lets Combine it With the Main Dataset
company_new <- cbind(company[,-1], High) #Here we Exclude the Sales Column as we have Derived a responsive Variable High using it

#Lets Create the Training and Testing sets
indatapartition <- createDataPartition(company_new$High, p=.70, list = F) #This will Hold 70% of the whole dataset
training <- company_new[indatapartition,]
testing <- company_new[-indatapartition,]

#Lets Fit the Model for Entire Data Now
tree_model <- C5.0(High~. , data =company_new)
summary(tree_model) #Here we can See there was an Error of 6.5%
tree_model

#Lets Plot the Tree
plot(tree_model)

#Lets Build the Model for Training Set and Then Predict he Values for Testing set
t_model <- C5.0(High~. , data = training, method ="class")
summary(t_model) #Here we can see that there is an Error rate of 8.5%
t_model

pred <- predict.C5.0(t_model, newdata = testing)
pred

a<- table(testing$High, pred)
Accuracy <- sum(diag(a))/sum(a)
Accuracy

CrossTable(testing$High, pred)

#So here we can see that there are Misclassifications, we can improve the models using Bagging and Boosting techniques
#We use For loop for bagging in order to make multiple models

acc<- c()
for (i in 1:50) #This will create 500 different models
{
  print(i)
  
  #Build  a Model
  fittree <- C5.0(High~. , data = training,method = "class", trials = 10) #Trials is a Boosting Parameter
  
  
  pred2<- predict.C5.0(fittree,testing[,-11])
  ab<- table(testing$High, pred2)
  
  #To save the Accuracy of the models
  acc<- c(acc,sum(diag(ab))/sum(ab)) 
}

summary(acc) 

summary(fittree)

plot(fittree)
