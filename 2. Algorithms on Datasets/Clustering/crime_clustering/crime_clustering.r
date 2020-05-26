
#Perform Clustering for the crime data and identify the number of clusters formed and draw inferences.
#Clustering for Crime Data


#Lets Do Heirarchical Clustering
crime<- read.csv("C:/Users/Mandar/Desktop/data/assignments/clustering/crime_data.csv")
   View(crime)
   
summary(crime)

crime01<- scale(crime[,2:5])

d<-dist(crime01, method = "euclidean")#Computing the distance matrix
d

#Lets do it Using Centroid Method

cluster01 = hclust(d, method = "centroid")#Building the algorithm for Centroid
plot(cluster01)#display dendogram

x <- cutree(cluster01,k= 4)#cut three into 4 clusters
x

#draw dendogram with red border aroound the 5 cluster
rect.hclust(cluster01, k=4, border = "red")

#attach the cluster number to unit
y <- data.frame("City"=crime[,1],"Cluster Number"= x)
y


#Lets Use Average Linkage Method

cluster02 <- hclust(d, method = "average")
plot(cluster02)#display dendogram

x1 <- cutree(cluster02, k=4)#cut three into 4 clusters
x1

#draw dendogram with blue border aroound the 5 cluster
rect.hclust(cluster02,k=4, border="blue")

y1<- data.frame("City"=crime[,1], "cluster number"= x1)
y1




#get the reference value of k
#the expriment in elbow plot-4 cluster:
#use the above k value as reference and run below for loop to
#find optimum k value
wss <- c()
for (i in 2:15) wss[i]<- sum(kmeans(d, centers = i)$withinss)
plot(1:15,wss,type = "b", xlab = "No of Clusters", ylab = "Avg Distance")

#Lets take the Value of K as 3 as obtained by Elbow Plot

k_mean_cluster <- kmeans(d,3)
k_mean_cluster$centers
k_mean_cluster$cluster

final_Cluster_info <- data.frame("City"=crime[,1], "Cluster"=k_mean_cluster$cluster)


