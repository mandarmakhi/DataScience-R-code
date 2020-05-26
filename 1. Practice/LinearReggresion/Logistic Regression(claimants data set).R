claimants <- read.csv("C:/Users/Mandar/Desktop/excelr/claimants.csv")
View(claimants)


#logistic regression(y/n)

sum(is.na(claimants))
claimants<- na.omit(claimants)#omitting NA value from the data


#na.omit=> will omit the row which has atleast 1 NA value
dim(claimants)
claimants<-claimants[,1]#removing the first column which is an index


#preparing a linear regression
mod_lm <-lm(ATTORNEY~.,data=claimants)
pred1<- predict(mod_lm,claimants)
pred1
plot(claimants$CLMINSUR,pred1)


#we can no way to use the linear regression tchenique to classify the data
plot(pred1)


#GLM function use sigmoid curve to produce desirable result
#the output of digmoid function lies in between 0-1
model<-glm(ATTORNEY~.,data=claimants,family="binomial")
summary(model)


#confusion matrix table
prob<-predict(model,claimants,type="response")
prob


#confusion matrix and considering the thershold value as 0.5
confusion<-table(prob>0.5,claimants$ATTORNEY)
confusion


#model accuracy
accuracy<-sum(diag(confusion)/sum(confusion))
accuracy #70.62
