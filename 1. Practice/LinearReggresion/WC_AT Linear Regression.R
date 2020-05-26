#load data
WC_AT <- read.csv("C:/Users/Mandar/Desktop/excelr/WC_AT.csv")
View(WC_AT)

library("lattice")
dotplot(WC_AT$Waist, main="Dot Plot of waist", col="dodgerblue4")
dotplot(WC_AT$AT, main="Dot Plot of AT", col="dodgerblue4")
dotplot(WC_AT,col="red")






model<- lm(AT~Waist,data=WC_AT)
summary(model)

new<-data.frame(Waist=c(60,70))
pred<-predict(model,newdata=new)
pred<-predict(model)
finaldat<- data.frame(WC_AT,pred,"ERROR"=WC_AT$Waist-pred)
