#Association Rule

#Prepare rules for the all the data sets 
#1) Try different values of support and confidence. Observe the change in number of rules for different support,confidence values
#2) Change the minimum length in apriori algorithm
#3) Visulize the obtained rules using different plots 



install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)
groceries <- read.transactions(file.choose(), format = "basket")
 View(groceries)
 head(groceries)
 summary(groceries)
 
 LIST(head(groceries),3) #This Converts a Transaction into list
 
 size(head(groceries)) #Gives the Number of Items in eac Itemset
 
 x<- eclat(groceries, parameter = list(supp = 0.03, maxlen = 10)) # we can Calcualtes 3% Support for Every Frequent Item
 inspect(x)
 arules::inspect(x)
 itemFrequencyPlot(groceries, topN=20, type = "absolute") #This Plot is Only Applicable on Transactions
 
 #Lets Prepare the Rules
 rule1 <- apriori(groceries, parameter = list(supp = 0.002, conf = 0.5))
 inspect(head(rule1))
 rule1 #Prepares set of 89 rules
 
 rule_lift <- sort(rule1, by = "lift", decreasing = TRUE)
 inspect(head(rule_lift))
 
 rule_conf <- sort(rule1, by = "confidence", decreasing = TRUE)
 inspect(head(rule_conf))
 
 plot(rule1, method = "scatterplot")
 
 #Lets Create more rules with Different Parameters
 itemLabels(groceries)
 rule2 <- apriori(groceries, parameter = list(supp = 0.001, conf = 0.08), appearance = list(rhs = "chocolate"))
 inspect(head(rule2))
 rule2
 plot(rule2, method = "grouped")
 
 rule3 <- apriori (data=groceries, parameter=list (supp=0.001,conf = 0.08), appearance = list(default="rhs",lhs="bread"))
 inspect(head(rule3))
 plot(rule3, method = "two-key plot")
 
 rule4 <- apriori (groceries, parameter = list(supp = 0.005, conf = 0.09))
 rule4
 inspect(head(rule4))
 plot(rule4, method = "graph")
 
 