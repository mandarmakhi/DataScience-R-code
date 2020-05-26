#import dataset iris
iris<-datasets::iris
View(iris)
data("iris")

#install packages caret and C50
install.packages("caret")
install.packages("C50")

library(caret)
library(C50)

#create partition for the main dataset 
inTraininglocal<-createDataPartition(iris$Species,p=.70,list=F)
training<-iris[inTraininglocal,]#training is one partition
testing<-iris[-inTraininglocal,]#testing is another partition

#model building
model<-C5.0(training$Species~.,data=training)

#generate the model summary
summary(model)

#Predict for test data set
pred<-predict.C5.0(model,testing[,-5])
a<-table(testing$Species,pred)
a
sum(diag(a))/sum(a)
plot(model)#plot the decision tree
