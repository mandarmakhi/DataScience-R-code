#Clustering Algorithm

#Perform clustering (Both hierarchical and K means clustering) for the airlines data to obtain optimum number of clusters. 
#Draw the inferences from the clusters obtained.

#We will DO Heirarchical as well as K-Means Clustering




#Use the Below Library to import Excel Files 
install.packages("xlsx")
library(xlsx)
airlines <- read.xlsx("C:\\Users\\Mandar\\Desktop\\data\\assignments\\clustering\\EastWestAirlines.xlsx",2)
summary(airlines)
airlines1 <- (scale(airlines[2:12]))

d <- dist(airlines01, method = "euclidean")#Computing the distance matrix
d

#Using Centroid method


heirarchical_centroid <- hclust(d, method = "centroid")#Building the algorithm for Centroid

plot(heirarchical_centroid)#display dendogram

clusterGroup <- cutree(heirarchical_centroid,10)#cut three into 4 clusters


#draw dendogram with blue border aroound the 5 cluster
rect.hclust(heirarchical_centroid,5,border = "blue")

heirarchical_centroid_Data <- data.frame(airlines[,1],clusterGroup)

table(clusterGroup) #To see the Number of Customers in Each Group

#Using Average Linkage Method
Heirarchical_Average <- hclust(d, method = "average")

plot(Heirarchical_Average)

clustergroup <- cutree(Heirarchical_Average, 10)

rect.hclust(Heirarchical_Average, 8,border = "Blue")

Heirarchical_Average_data <- data.frame(airlines[,1], clustergroup)

table(clustergroup)

#Now lets do K-Means Clustering on the data

wss <- c()
for (i in 2:15) wss[i]<- sum(kmeans(airlines1, centers = i)$withinss)
plot(1:15,wss,type = "b", xlab = "No of Clusters", ylab = "Avg Distance")

#Using the Elbow Plot we got the k value as 5

k_means_airline <- kmeans(d,5)

#If you want to See the Animated view of the Clusters then run the below Statements
install.packages("animation")
library(animation)
windows()
k_means_airline <- kmeans.ani(d,5)

k_means_airline_clusters <- data.frame(airlines[,1], k_means_airline$cluster)

