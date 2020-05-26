####Support Vector Machine -------------------------
#optical character recognition

letterdata <- read.csv("C:/Users/Mandar/Desktop/data/csv files/letterdata.csv")
   View(letterdata)
   
   
   #divide into training and test data
   letterdata_train<-letterdata[1:1600,]
   letterdata_test<-letterdata[16001:20000,]   

   
   ##training a model on the data----
   #begin by training a simple linear SVM
   library(kernlab)
   letterdata_classifier<-ksvm(letter~.,data=letterdata_train, kernel="vanilladot")

   
   ##Evaluation model performance---
   #prediction on testing dataset
   letterdata_classifier<-ksvm(letter~.,data=letterdata_train, kernel="vanilladot")
  head(letterdata_predictions)

table(letterdata_predictions,letterdata_test$letter)
agreement<-letterdata_predictions==letterdata_test$letter
prop.table(table(agreement))

##improving model performance---

letterdata_classifier_rbf<-ksvm(letter~.,data=letterdata_train,
                                kernel="rbfdot")
letterdata_predictions_rbf<-predict(letterdata_classifier_rbf,
                                    letterdata_test)
head(letterdata_predictions_rbf)

agreement_rbf<-letterdata_predictions_rbf==letterdata_test$letter
table(agreement_rbf)
prop.table(table(agreement_rbf))
