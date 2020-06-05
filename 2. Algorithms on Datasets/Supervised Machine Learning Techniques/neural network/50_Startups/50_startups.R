#Neural Network Algorithm

#Build a Neural Network model for 50_startups data to predict profit 

library(neuralnet)


startup <- read.csv(file.choose())
View(startup)
attach(startup)
head(startup)
names(startup)


summary(startup)
sum(is.na(startup))
dim(startup)



startup01 <- startup[,-4] 

cor(startup01) 

#Standard Deviation
sd(R.D.Spend)
sd(Administration)
sd(Marketing.Spend)
sd(Profit)

#Variance
var(R.D.Spend)
var(Administration)
var(Marketing.Spend)
var(Profit)


plot(R.D.Spend,Administration, type = "h")

plot(Marketing.Spend,Profit, main = "Marketing Expense vs Profit")


#Lets Normalize the data
normalise <- function(x) {
  return((x - min(x))/(max(x) - min(x)))
}

startup_norm <- as.data.frame(lapply(startup01, normalise))

#Lets Split the Dataset into Train and Test Set Randomly
split <- sort(sample(nrow(startup_norm),nrow(startup_norm)*0.7))
train <- startup_norm[split,]
test <- startup_norm[-split,]

#Now Lets Build the Neural Network
x <- neuralnet(formula = Profit~ R.D.Spend + Administration + Marketing.Spend, data = train)
plot(x) 

#Lets predict the Profit and find the Accuracy of the Model
x_result <- compute(x, test[1:3])
profit <- x_result$net.result
round(cor(test$Profit,profit)*100, digits = 2)



x2 <- neuralnet(formula = Profit~. , data = train, hidden = 3)
plot(x2) 

x2_results <- compute(x2, test[1:3])
profit2 <- x2_results$net.result
round(cor(test[,4],profit2)*100, digits = 2)



x3 <- neuralnet(formula = Profit~. , data = train, hidden = c(5,2))
plot(x3)

x3_results <- compute(x3,test[1:3])
profit3 <- x3_results$net.result
round(cor(test[,4], profit3)*100, digits = 2)


#Lets Build the Model Using the Scaled Values of the Dataset

startup_scaled <- as.data.frame(scale(startup01))

#Split the data randomly in Train and test set
train1 <- startup_scaled[split,]
test1 <- startup_scaled[-split,]


n11 <- neuralnet(formula = Profit~. , data = train1)
plot(n11)

n11_results <- compute(n11, test1[1:3])
profit11 <- n11_results$net.result
round(cor(test1[,4], profit11)*100, digits = 2)


n12 <- neuralnet(formula = Profit~. , data = train1, hidden = c(3,2))
plot(n12) 

n12_results <- compute(n12, test1[1:3])
profit12 <- n12_results$net.result
round(cor(test1[,4], profit12)*100, digits = 2)


n13 <- neuralnet(formula = Profit~. , data = train1, hidden = c(4,3,2,2))
plot(n13) 

n13_results <- compute(n13, test1[1:3])
profit13 <- n13_results$net.result
round(cor(test1[,4], profit13)*100, digits = 2)
