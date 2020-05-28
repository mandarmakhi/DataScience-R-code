#Logistic Regression

#Classify whether application accepted or not using Logistic regression


creditcard <- read.csv(file.choose())
attach(creditcard)
summary(creditcard)
head(creditcard)
names(creditcard)


creditcard01 <- creditcard[,-1]



#Lets convert the Categorical columns into Factors
card <- as.factor(card)
owner <- as.factor(owner)
selfemp <- as.factor(selfemp)
summary(creditcard01)

sum(is.na(creditcard01)) 

#Lets build a Logistic Regression Model

credit_model <- glm(card~. , data = creditcard01, family = "binomial")
summary(credit_model)

pred <- predict(credit_model,type = "response")
pred

#lets make a confusion matrix
conf<- table(pred>0.5, creditcard01$card)
conf

#Lets find the Accuracy of the Model
accuracy <- sum(diag(conf)/sum(conf))
accuracy


final <- data.frame(creditcard01$card, pred)


install.packages("pROC")
library(pROC)

creditcard02 <- roc(creditcard01$card, pred)
creditcard02

se<-creditcard02$sensitivities
se

sp <-creditcard02$specificities

credit_data <- data.frame(se, sp)
credit_data

library(ggplot2)

ggplot(credit_data, aes(x=sp, y=se)+ geom_line())


