# 1) Calories_consumed-> predict weight gained using calories consumed

calories_consumed <- read.csv("C:/Users/Mandar/Desktop/data/assignments/simple linear/calories_simplelinear/calories_consumed.csv")
   View(calories_consumed)
   attach(calories_consumed)
   head(calories_consumed)
   tail(calories_consumed)
   summary(calories_consumed)

#Gives the Standard DEviation of the Column
sd(calories_consumed$Weight.gained..grams.)
sd(calories_consumed$Calories.Consumed)


#Gives the Variance of the Column
var(calories_consumed$Weight.gained..grams.)
var(calories_consumed$Calories.Consumed)

cor(calories_consumed)


plot(calories_consumed)


#Lets Build a Linear Model
calorie_model <- lm(calories_consumed$Weight.gained..grams.~. , data = calories_consumed)
summary(calorie_model)
#R-Sqaured value for the above model is 0.8968 and the p-value is less than 0.05 
#That means this model will predict the output 89.68% time correct.
#with Residual Standard Error as 111.6


#Lets do some Data Trnsformation and build the model to get better R-Square Value

calorie_sqrt_model <- lm(sqrt(calories_consumed$Weight.gained..grams.)~. , data = calories_consumed)
summary(calorie_sqrt_model)


#log transformation
calorie_log_model <-lm(log(calories_consumed$Weight.gained..grams.)~.,data=calories_consumed)
summary(calorie_log_model)


