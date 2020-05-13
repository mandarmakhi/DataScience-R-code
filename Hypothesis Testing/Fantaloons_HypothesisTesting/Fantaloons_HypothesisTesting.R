#Hypothesis Testing
#Fantaloons Sales managers commented that % of males versus females walking in to the store differ based on day of the week. Analyze the data and determine whether there is evidence at 5 % significance level to support this hypothesis.

#h0: = (Proportion of male and female is same)
#ha: != (Proportion of male and female is not same)

fantaloons <- read.csv("C:/Users/Mandar/Desktop/data/assignments/Hypothesis Testing/Faltoons.csv")
  View(fantaloons)
summary(fantaloons)

fanta <- as.data.frame(as.factor(fantaloons$Weekdays), as.factor(fantaloons$Weekend))

fanta1 <- fantaloons
fanta1$Weekdays <- as.factor(fanta1$Weekdays)
fanta1$Weekend<- as.factor(fanta1$Weekend)
summary(fanta1)

fanta2 <- data.frame("Weekdays"=c(287,113), "Weekend" = c(233,167))
row.names(fanta2) <- c("Female","Male")

#now lets use the chisq.test() to test the hypothesis on fanta2
chisq.test(fanta2)

