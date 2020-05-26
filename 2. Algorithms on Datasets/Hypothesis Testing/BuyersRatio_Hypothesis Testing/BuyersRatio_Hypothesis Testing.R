#Hypothesis Testing

#h0: = (Male-female ratio is equal across all regions)
#ha: != (Male-female ratio is not equal accross regions)

#Lets import the data
buyer_ratio <- read.csv("C:/Users/Mandar/Desktop/data/assignments/Hypothesis Testing/BuyerRatio.csv")
  View(buyer_ratio)
summary(buyer_ratio)

#Lets remove the first column
buyer1 <- buyer_ratio[,2:5]

#As we can see that we have categorical data in the dataset, we will do the chisq.test() to see 
#if there is correlation between the columns

test <- chisq.test(buyer1)
test

