
#Hypothesis Testing
#Analyze the data and determine whether there is any difference in average TAT among the different laboratories at 5% significance level
#H0: = 0 (Average TAT are same)
#Ha: !=0 (Average TAT are not same)

LabTAT <- read.csv("C:/Users/Mandar/Desktop/data/assignments/Hypothesis Testing/LabTAT.csv")
  View(LabTAT)
lab1 <- LabTAT$Laboratory.1
lab2 <- LabTAT$Laboratory.2
lab3 <- LabTAT$Laboratory.3
lab4 <- LabTAT$Laboratory.4

summary(LabTAT)
sd(lab1)
sd(lab2)
sd(lab3)
sd(lab4)

combined_group <- data.frame(cbind(lab1,lab2,lab3,lab4))
combined_group

stacked_group <- stack(combined_group)
stacked_group

anova_result <- aov(stacked_group$values~. , data = stacked_group)
anova_result
summary(anova_result)
#The p value is less than 0.05 i.e 5% significance level so we reject H0 and the result is 
