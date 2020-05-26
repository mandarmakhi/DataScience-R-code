#data load
universities <- read.csv("C:/Users/Mandar/Desktop/excelr/universities.csv")
View(universities)

###########################################

universities<- scale(universities[,2:7])
d<- dist(universities,method="euclidean")#Computing the distance matrix
fit<- hclust(d,method ="average")#Building the algorithm for average '
plot(fit)#display dendogram
groups<-cutree(fit,k=4)#cut three into 4 clusters
#draw dendogram with red border aroound the 5 cluster
rect.hclust(fit,k=4,border ="red")
#attach the cluster number to uni
clusters=data.frame('Uni'=universities[,1],'Cluster'=groups)

fit<-hclust(d,method="centroid")#bulding the algorithm centroid
plot(fit)

fit<-hclust(d,method="complete")#bulding the algorithm complete
plot(fit)

fit<-hclust(d,method="single")#bulding the algorithm single
plot(fit)
