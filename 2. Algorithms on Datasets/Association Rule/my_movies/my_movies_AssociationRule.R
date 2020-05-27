#Association Rule
#Prepare rules for the all the data sets 
# 1) Try different values of support and confidence. Observe the change in number of rules for different support,confidence values
# 2) Change the minimum length in apriori algorithm
# 3) Visulize the obtained rules using different plots 

install.packages("arules")
install.packages("arulesViz")

library(arules)
library(arulesViz)

movies <- read.csv("C:/Users/Mandar/Desktop/data/assignments/association rule/my_movies.csv")
   View(movies)
   head(movies)
   attach(movies)
   names(movies)
   
   summary(movies)
   
#we have the Data represented in Transaction as well as Binary Variables

   x <- apriori(as.matrix(movies[,6:15]), parameter = list(supp = 0.05 , conf = 0.8))
   x #set of 77 rules
   arules::inspect(x)
  
   
   X1<- head(x, by="confidence", n=20)
  
   x_lift<-sort(x,by="lift",decreasing = TRUE)
   x_conf<-sort(x,by="confidence", decreasing = TRUE)   
   
   plot(x_conf, method = "grouped")   
   plot(X1, method="graph", engine="htmlwidget")   
  
#create Other Rules with Different Parameters and Plot them
   
   y<-apriori(as.matrix(movies[,6:15],parameter=list(support=0.8, confidence = 1,minlen=6)))
   y #set of 77 rules
   arules::inspect(y)
   
   plot(y, method = "two-key plot")   

   
   z<-  apriori(as.matrix(movies[,6:15],parameter=list(support=0.6, confidence =0.7,minlen=5)))
   z#set of 77 rules
   arules::inspect(z)
   
   plot(z, method = "scatterplot")
   
   plot(z, method = "paracoord")
   