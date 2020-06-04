#Support Vector Machine

#classify the Size_Categorie using SVM
library(caret)
library(kernlab)
library(ggplot2)

forest <- read.csv(file.choose())
head(forest)
names(forest)

summary(forest)
attach(forest)

forest1 <- forest[,1:10]
forest1 <- cbind(forest1,size_category)
attach(forest1)

str(forest1)


#Convert the Character Variable into Categorical Variable

forest1$month <- as.factor(forest1$month)
forest1$day <- as.factor(forest1$day)
forest1$size_category <- as.factor(forest1$size_category)
rowsum(is.na(forest1[,3:10]))
#Plots

ggplot(forest1) + geom_density(aes(FFMC), stat = "density") + theme_classic()

ggplot(forest1) + geom_bar(aes(DC),binwidth = 10, fill = "blue")

ggplot(forest1) + geom_bar(aes(temp), binwidth = 0.50, fill = "yellow") + theme_classic()

plot(wind, rain, type = "p", xlab = "Wind", ylab = "rain")

#Lets Divide the Data in Training and Testing Set

partdata <- createDataPartition(forest1$size_category, p=.70, list = F)
train1 <- forest1[partdata,]
test1 <- forest1[-partdata,]

#Lets Build the Models

model <- ksvm(size_category~. , data = train1, kernel = "vanilladot") #Vanilladot - Linear kernel
model


pred <- predict(model, test1[,-11])
tab <- table(test1[,11], pred)
equals <- test1[,11] == pred
prop.table(table(equals))


#lets build Models using Different Kernels and Compare their Accuracy

model1 <- ksvm(size_category~. , data =train1, kernel = "rbfdot") # rbfdot - radial basis function kernel(Gaussian) #Sigma parametr can be used
model1 

pred1 <- predict(model1, test1[-11])
tab1 <- table(test1[,11], pred1)
equals1 <-test1[,11] == pred1
prop.table(table(equals1))


model2 <- ksvm(size_category~. , data =train1, kernel = "polydot", kpar = list(degree = 2, scale = 2)) #polydot - Polynomial kernel
model2 

pred2 <- predict(model2, test1[-11])
tab2 <- table(test1[,11], pred2)
equals2 <-test1[,11] == pred2
prop.table(table(equals2))


model3 <- ksvm(size_category~. , data = train1, kernel = "tanhdot") #tanhdot - Hyperbolic Tangent kernel
model3 

pred3 <- predict(model3,test1[-11])
tab3 <- table(test1[,11], pred3)
equals3 <- test1[,11] == pred3
prop.table(table(equals3))


model4 <- ksvm(size_category~. , data = train1, kernel = "laplacedot", kpar = list(sigma =2), C = 8) #laplacedot - Laplacian kernel
model4 

pred4 <- predict(model4, test1[-11])
tab4 <- table(test1[,11], pred4)
equals4 <- test1[,11] == pred4
prop.table(table(equals4))


model5 <- ksvm(size_category~. , data = train1, kernel = "anovadot") #anovadot - ANOVA RBF kernel - parameters(Sigma, degree)
model5 

pred5 <- predict(model5,test1[-11])
tab5 <- table(test1[,11], pred5)
equals5 <- test1[,11] == pred5
prop.table(table(equals5))

model6 <- ksvm(size_category~. , data = train1, kernel = "splinedot", C=10) #splinedot - spline kernel 
model6 

pred6 <- predict(model6,test1[-11])
tab6 <- table(test1[,11], pred6)
equals6 <- test1[,11] == pred6
prop.table(table(equals6))


model7 <- ksvm(size_category~. , data = train1, kernel = "besseldot", kpar = list(degree = 2), C= 15) #besseldot - String kernel - parameters(degree, sigma,order)
model7

pred7 <- predict(model7, test1[-11])
tab7 <- table(test1[,11], pred7)
equals7 <- test1[,11] == pred7
prop.table(table(equals7))


#The Laplacedot Kernel Model has the Least Training Error with a Accuracy of 71.42%
