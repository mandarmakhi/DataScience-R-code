Zoo <- read.csv("C:/Users/Mandar/Desktop/data/assignments/KNN/Zoo.csv")
 View(Zoo)
str(Zoo)
  Zoo<-Zoo[,-1]
 #table of diagnosis
 table(Zoo$type) 
 #table or proportions with more information lable
 round(prop.table(table(Zoo$type))*100,digits = 1)
 #create normalization function
 normalize<-function(x){
   return((x-min(x))/(max(x)-min(x)))
 } 
 
 KNN_n<- as.data.frame(lapply(Zoo[2:17],normalize))
 KNN_nl<-cbind(KNN_n,Zoo$type)
 
 #create training and test data
 KNN_train<-KNN_n[1:51,]
 KNN_test<-KNN_n[52:101,]
 #create lable for tranining and test data
 KNN_train_lable<-KNN[1:51,17]
 KNN_test_lable<-KNN[52:101,17] 

 KNN_test_lable
 KNN_train_lable
 KNN_n
 KNN_nl

 library(class)
 KNN_test_pred<- knn(train= KNN_train, test=KNN_test,  cl=KNN_train_lable,k=20) 

 
 
 
 
 #-----------------------------evaluating model performance--------------------
 
 library(gmodels)
 #create the cross tabulation of predicated vs. actual
 CrossTable(x=KNN_test_lable,y=KNN_test_pred,prop.c = FALSE)
 
 
 ###########################################################################
 ####Improving model performance---
 
 #use the scale()function to z-score standardize a data frame
 KNN_z<- as.data.frame(scale(Zoo[-1]))
 
 #create training and test datasets
 KNN_train<- KNN_z[1:51,]
 KNN_test<- KNN_z[52:101,]
 
 #re-classify test cases
 KNN_test_pred<- knn(train= KNN_train, test=KNN_test,  cl=KNN_train_lable,k=21)
 
 #create the cross tabulation of predicted vs. actual
 CrossTable(x=KNN_test_lable,y=KNN_test_pred,prop.r  = FALSE,prop.chisq = FALSE, prop.c = FALSE)
 
 #try several diffrent values of k
 KNN_train<-KNN_n[1:51,]
 KNN_test<-KNN_n[52:101,]
 
 
 KNN_test_pred<- knn(train= KNN_train, test=KNN_test,  cl=KNN_train_lable,k=1)
 CrossTable(x=KNN_test_lable,y=KNN_test_pred,prop.r  = FALSE,prop.chisq = FALSE, prop.c = FALSE)
 plot(KNN_test_pred)
 
 KNN_test_pred<- knn(train= KNN_train, test=KNN_test,  cl=KNN_train_lable,k=11)
 CrossTable(x=KNN_test_lable,y=KNN_test_pred,prop.r  = FALSE,prop.chisq = FALSE, prop.c = FALSE)
 plot(KNN_test_pred)
 
 KNN_test_pred<- knn(train= KNN_train, test=KNN_test,  cl=KNN_train_lable,k=21)
 CrossTable(x=KNN_test_lable,y=KNN_test_pred,prop.r  = FALSE,prop.chisq = FALSE, prop.c = FALSE)
 plot(KNN_test_pred)
 
 KNN_test_pred<- knn(train= KNN_train, test=KNN_test,  cl=KNN_train_lable,k=31)
 CrossTable(x=KNN_test_lable,y=KNN_test_pred,prop.r  = FALSE,prop.chisq = FALSE, prop.c = FALSE)
plot(KNN_test_pred) 
KNN_test_pred
