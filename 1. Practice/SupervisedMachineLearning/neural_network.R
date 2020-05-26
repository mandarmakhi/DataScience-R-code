#apply normalization to entire data frame
concrete <- read.csv("C:/Users/Mandar/Desktop/data/csv files/concrete.csv")
  View(concrete)
  concrete_norm<- as.data.frame(lapply(concrete, normalize))
  #create training and test data
  concrete_train<- concrete_norm[1:773,]
  concrete_test<- concrete_norm[774:1030,]  
#training a model on the data---
  #train the neuralnet model
  library(neuralnet)
#simple ANN with only a single hidden neuron
  concrete_model<-neuralnet(formula = strength~cement+slag+ash+water+superplastic+coarseagg+
                              fineagg+age,data=concrete_train)
#visualize the network topology
  windows()
plot(concrete_model)  
##Evaluating model performance-------
#obtain model results
model_results<-compute(concrete_model,concrete_test[1:8])
#obtain predicted strength values
predicted_strength<-model_results$net.result
#examine the correlation between predicted and actual values
cor(predicted_strength,concrete_test$strength)
#inproving model performance--
#a more complex neural network toploogy with5 hidden neurons
concrete_model2<-neuralnet(strength~cement+slag+ash+water+superplastic+coarseagg+
                             fineagg+age,data=concrete_train,hidden=c(5,2))
#plot the network
windows()
plot(concrete_model2)
#evaluate the result as we did before
model_results2<-compute(concrete_model2,concrete_test[1:8])
predicted_strength2<-model_results2$net.result
cor(predicted_strength2,concrete_test$strength)
