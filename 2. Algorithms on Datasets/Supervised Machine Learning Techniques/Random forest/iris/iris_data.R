#Random forest

#we Build a Random Forest for the Iris Data 

datasets::iris
data("iris")
attach(iris)

library(caret)
library(randomForest)

summary(iris)
names(iris)

dim(iris) 

str(iris) 

#Standard Deviation
sd(iris$Sepal.Length)
sd(iris$Sepal.Width)
sd(iris$Petal.Length)
sd(iris$Petal.Width)

#Variance
var(iris$Sepal.Length)
var(iris$Sepal.Width)
var(iris$Petal.Length)
var(iris$Petal.Width)

boxplot(iris) 
pairs(iris) 

#Lets Divide the Data for building the model
inTraininglocal <- createDataPartition(iris$Species,p=.70,list = F) 
training<- iris[inTraininglocal,]
testing<- iris[-inTraininglocal,]

#Lets Build the Random forest Model
rf1 <- randomForest(Species~. , data = training, ntree = 500)
rf1
print(importance(rf1))
pred1 <- predict(rf1, testing[,-5])
CrossTable(testing[,5], pred1)
tab1 <- table(testing[,5], pred1)
sum(diag(tab1))/ sum(tab1)

rf2 <- randomForest(Species~. , data = training, ntree = 1000)
rf2
print(importance(rf2))
pred2 <- predict(rf2, testing[,-5])
CrossTable(testing[,5], pred2)
tab2 <- table(testing[,5], pred2)
sum(diag(tab2))/ sum(tab2)

rf3 <- randomForest(Species~. , data = training, ntree = 1500)
rf3
print(importance(rf3))
pred3 <- predict(rf3, testing[,-5])
CrossTable(testing[,5], pred3)
tab3 <- table(testing[,5], pred3)
sum(diag(tab3))/ sum(tab3)

