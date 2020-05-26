install.packages("plyr")
library(plyr)
X<- runif(50)#generating 50 random number from uniform distribution(0,1)
y<- runif(50)#generating 50 random number
 data<-cbind(X,y)
plot(data) 
#get the reference value of k
#the expriment in elbow plt-4 cluster:
#use the above k value as reference and run below for loop to
#find optimum k value
wss<-c()
for(i in 2:15)wss[i]<-sum(kmeans(data,centers = i)$withinss)
plot(1:15,wss,type="b",xlab="no of clusters",ylab="avg distance")

##cluster algorithm building
km<-kmeans(data,8)
km$centers
km$cluster
##
install.packages("animation")
library(animation)
window()
km<- kmeans.ani(data,7)

######
#windows()

