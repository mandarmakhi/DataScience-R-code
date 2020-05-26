install.packages("caret",dependencies = TRUE)
installed.packages("randomForest")


library(randomForest)


model<-randomForest(iris$Species~.,data = iris,ntree=1000)

#view the forest results 
print(model)


#Imoporantce of the variable-lower gini
print(importance(model))


#prediction
pred<- predict(model,iris[,-5])
table(pred,iris$Species)
