Cars <- read.csv("C:/Users/Mandar/Desktop/excelr/Cars.csv")
  View(Cars)
  
  #scatter plot Matrix:
  pairs(Cars)

  #Correlation Matrix:
  car(Cars)
  
  #Regression Model and Summary
  model.Cars<-lm(MPG~VOL+SP+HP+WT,data=Cars)
  summary(model.Cars)

  
    