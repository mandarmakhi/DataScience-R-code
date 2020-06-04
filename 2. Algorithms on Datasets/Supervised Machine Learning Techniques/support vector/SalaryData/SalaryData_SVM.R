
# Support Vector Machine(SVM)

# salary data 

library(kernlab)
library(ggplot2)
library(dplyr)

#train data
salary_train <- read.csv(file.choose()) 
attach(salary_train)
head(salary_train)

names(salary_train)


summary(salary_train)
str(salary_train)



salary_train$workclass <- as.factor(salary_train$workclass)
salary_train$education <-as.factor(salary_train$education)
salary_train$maritalstatus <- as.factor(salary_train$maritalstatus)
salary_train$occupation <- as.factor(salary_train$occupation)
salary_train$relationship <- as.factor(salary_train$relationship)
salary_train$race <- as.factor(salary_train$race)
salary_train$sex <- as.factor(salary_train$sex)
salary_train$native <- as.factor(salary_train$native)
salary_train$Salary <- as.factor(salary_train$Salary)


#test datset
salary_test <- read.csv(file.choose()) #This data is used to Test the Model
attach(salary_test)
head(salary_test)

names(salary_test)

summary(salary_test)
str(salary_test)


salary_test$workclass <- as.factor(salary_test$workclass)
salary_test$education <-as.factor(salary_test$education)
salary_test$maritalstatus <- as.factor(salary_test$maritalstatus)
salary_test$occupation <- as.factor(salary_test$occupation)
salary_test$relationship <- as.factor(salary_test$relationship)
salary_test$race <- as.factor(salary_test$race)
salary_test$sex <- as.factor(salary_test$sex)
salary_test$native <- as.factor(salary_test$native)
salary_test$Salary <- as.factor(salary_test$Salary)


ggplot(salary_train, aes(x = sex,y = education)) + geom_bar(stat = "Identity") + theme_bw()

# build the SVM model 
model1 <- ksvm(Salary~. , data = salary_train, kernel = "vanilladot") #Vanilladot - Linear kernel
model1


pred1 <- predict(model1, salary_test[-14])
tab1 <- table(salary_test[,14], pred1)
equals <- salary_test[,14] == pred1
prop.table(table(equals))



model2 <- ksvm(Salary~. , data = salary_train, kernel = "rbfdot") # rbfdot - radial basis function kernel(Gaussian) #Sigma parametr can be used
model2 

pred2 <- predict(model2, salary_test[-14])
tab2 <- table(salary_test[,14], pred2)
equals2 <- salary_test[,14] == pred2
prop.table(table(equals2))


model3 <- ksvm(Salary~. , data = salary_train, kernel = "polydot", kpar = list(degree = 2, scale = 1)) #polydot - Polynomial kernel
model3 

pred3 <- predict(model3, salary_test[-14])
tab3 <- table(salary_test[,14], pred3)
equals3 <- salary_test[,14] == pred3
prop.table(table(equals3))


model4 <- ksvm(Salary~. , data = salary_train, kernel = "tanhdot") #tanhdot - Hyperbolic Tangent kernel
model4 

pred4 <- predict(model4, salary_test[-14])
tab4 <- table(salary_test[,14], pred4)
equals4 <- salary_test[,14] == pred4
prop.table(table(equals4))


model5 <- ksvm(Salary~. , data = salary_train, kernel = "laplacedot", kpar = list(sigma =1.5), C = 1.5) #laplacedot - Laplacian kernel
model5

pred5 <- predict(model5, salary_test[-14])
tab5 <- table(salary_test[,14], pred5)
equals5 <- salary_test[,14] == pred5
prop.table(table(equals5))


model6 <- ksvm(Salary~. , data = salary_train, kernel = "anovadot") #anovadot - ANOVA RBF kernel - parameters(Sigma, degree)
model6 

pred6 <- predict(model6, salary_test[-14])
tab6 <- table(salary_test[,14], pred6)
equals6 <- salary_test[,14] == pred6
prop.table(table(equals6))

model7 <- ksvm(Salary~. , data = salary_train, kernel = "splinedot", C=10) #splinedot - spline kernel 
model7 

pred7 <- predict(model7, salary_test[-14])
tab7 <- table(salary_test[,14], pred7)
equals7 <- salary_test[,14] == pred7
prop.table(table(equals7))


model8 <- ksvm(Salary~. , data = salary_train, kernel = "besseldot", kpar = list(degree = 2), C= 15) #besseldot - String kernel - parameters(degree, sigma,order)
model8

pred8 <- predict(model8, salary_test[-14])
tab8 <- table(salary_test[,14], pred8)
equals8 <- salary_test[,14] == pred8
prop.table(table(equals8))



#Hence, Laplacedot kernel Model is the best Model for Prediction for this Dataset