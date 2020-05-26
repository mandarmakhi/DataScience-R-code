data("iris")
install.packages("C50")
install.packages("caret")
library(caret)
library(C50)
View(iris)
inTraininglocal<-createDataPartition(iris$Species,p=.70,list=F)
training<-iris[inTraininglocal,]
testing<-iris[-inTraininglocal,]
#Model Bulding
model<-C5.0(training$Species~.,data=training)#Trails Bosstinh Parameter
#Generate the model
summary(model)
#predict for test data set
pred<-predict.C5.0(model,testing[,-5])
a<- table(testing$Species,pred)
sum(diag(a))/sum(a)
plot(model)