#Random forest

#A cloth manufacturing company is interested to know about the segment or attributes causes high sale. 



install.packages("randomForest")
install.packages("dismo")
install.packages("caret", dependencies = TRUE)

library(randomForest)
library(caret)
library(gmodels)
library(pROC)
library(DMwR)
library(dplyr)
library(dismo)

#Lets Import the Dataset
company <- read.csv(file.choose())
attach(company)
head(company)
names(company)

summary(company) 
str(company) 

#we see that there are 8 columns with numeric Variable and 3 columns with character Variable then Lets Covert the Character Variables into Categorical Variable



company$ShelveLoc <- as.factor(company$ShelveLoc)
company$Urban <- as.factor(company$Urban)
company$US <- as.factor(company$US)

#Standard Deviation & Variance
sd(Sales)
var(Sales)

sd(CompPrice)
var(CompPrice)

sd(Income)
var(Income)

sd(Advertising)
var(Advertising)

sd(Population)
var(Population)

sd(Price)
var(Price)

sd(Age)
var(Age)

sd(Education)
var(Education)



#Correlation matrix
cor(company[,-c(7,10,11)]) 

#Lets Plot the Data

ggplot(company) + geom_histogram(aes(Sales),binwidth = 0.5, color = "blue")

ggplot(company) + geom_histogram(aes(CompPrice),binwidth = 10, color = "black")

ggplot(company) + geom_histogram(aes(Income),binwidth = 1, color = "green")

ggplot(company) + geom_histogram(aes(Advertising),binwidth = 0.4, color = "red")

ggplot(company) + geom_histogram(aes(Population),binwidth = 20, color = "cyan")

ggplot(company) + geom_histogram(aes(Price),binwidth = 9, color = "blue")

ggplot(company) + geom_histogram(aes(Age),binwidth = 0.7, color = "black")

ggplot(company) + geom_histogram(aes(Education),binwidth = 0.2, color = "cyan")



High <- ifelse(Sales > 8,"Yes","No")
High <- as.factor(High)

#Lets Combine it with the new Dataset

company_new <- cbind(company[,-1],High) 
str(company_new)
prop.table(table(company_new$High)) 

#Lets Create the Training and Testing sets
indatapartition <- createDataPartition(company_new$High, p=.60, list = F) 

training <- company_new[indatapartition,]
testing <- company_new[-indatapartition,]


#Lets Build a trainControl setup for the Training Class - K-Folds Technique
ctrl <- trainControl(method = "repeatedcv", number = 5, repeats = 15, verboseIter = TRUE, classProbs = TRUE)



#Lets Build a model for the Entire Dataset

rf01 <- randomForest(High~. , data = company_new, ntree = 100, type = "class") #ntree is the Number of trees
rf01 #Gives the Model Details
summary(rf01)#Gives the Summary of the Model
print(importance(rf01)) 

#Lets Predict the Values for the Whole Data and see the Accuracy
pred1<- predict(rf01, company_new[,-11])
tab1 <- table(company_new[,11], pred1)
tab1
Acc1 <- sum(diag(tab1))/sum(tab1)
Acc1

#Lets Make a loop for Different number of Trees
trees1 <- c(100,500,700,1100,1500)

acc <- c()
precision1 <- c()
recall1 <- c()
f1score <- c()
auc <- c()

for(i in trees1) {
  print(i)
  
  forest1 <- randomForest(High~. , data = training, trControl = ctrl,method = "gbm", ntree = i)
  forest1
  pred <- predict(forest1,testing[,-11], type = "response")
  conf <- confusionMatrix(pred,testing$High, mode = "everything")
  conf$byClass
  areaundercurve <- roc(response = testing$High, predictor =factor(pred, ordered = TRUE), decreasing = TRUE)
  acc <- c(acc, conf$overall[1])
  precision1 <- c(precision1, conf$byClass[5])
  recall1 <- c(recall1, conf$byClass[6])
  f1score <- c(f1score, conf$byClass[7])
  auc <- c(auc, areaundercurve$auc)
}
recall1
precision1
acc

Evaluation <-data.frame("No of Trees" = trees1, "Accuracy" = acc, "Precision" = precision1, "Recall" = recall1, "F1" = f1score, "AUC" = auc)
Evaluation




#Lets Normalize the Data and see if the Accuracy of the Model Increases

normalise <- function(x) {
  return((x - max(x))/(max(x) - min(x)))
}

company_norm <- as.data.frame(lapply(company_new[,-c(6,9,10,11)], normalise))
company_norm_data <- cbind(company_norm, company_new[,c(6,9,10,11)])
summary(company_norm_data)

#Lets Divide the Data in train and test set
indatapartition1 <- createDataPartition(company_norm_data$High, p=.60, list = F) 
testing1 <- company_new[-indatapartition1,]

#Lets Build the Model
rf02 <- randomForest(High~. , data = training1, ntree = 500)
rf02
print(importance(rf02))
pred2 <- predict(rf02, testing1[,-11])
tab2 <- table(testing1[,11], pred2)
tab2
Acc2 <- sum(diag(tab5))/sum(tab2)
Acc2
#So here we observe that the Accuracy has decreased

acc1 <- c()
precision11 <- c()
recall11 <- c()
f1score1 <- c()
auc1 <- c()

for(i in trees1) {
  print(i)
  
  forest11 <- randomForest(High~. , data = training1, trControl = ctrl,method = "gbm", ntree = i)
  forest11
  pred1 <- predict(forest11,testing1[,-11], type = "response")
  conf1 <- confusionMatrix(pred1,testing$High, mode = "everything")
  conf1$byClass
  areaundercurve1 <- roc(response = testing1$High, predictor =factor(pred1, ordered = TRUE), decreasing = TRUE)
  acc1 <- c(acc1, conf1$overall[1])
  precision11 <- c(precision11, conf1$byClass[5])
  recall11 <- c(recall11, conf1$byClass[6])
  f1score1 <- c(f1score1, conf1$byClass[7])
  auc1 <- c(auc1, areaundercurve1$auc)
}
recall11
precision11
acc1

Evaluation1 <-data.frame("No of Trees" = trees1, "Accuracy" = acc1, "Precision" = precision11, "Recall" = recall11, "F1" = f1score1, "AUC" = auc1)
Evaluation1

