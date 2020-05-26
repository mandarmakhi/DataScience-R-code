#airquality=read.csv
#In R Console extract data set

airquality<-datasets::airquality

head(airquality) #Run
tail(airquality) #Run
airquality$Temp #Run

#descriptive_stat
#It's show's median, mean, min, max
summary(airquality$Temp)
summary(airquality$Ozone)
summary(airquality$Wind)

#Ploat
plot(airquality$Ozone)
plot(airquality$Ozone,airquality$Temp)
plot(airquality) #Its scatter plot graph
summary(airquality)

#point' and Line
plot(airquality$Ozone, type='l')
plot(airquality$Ozone, xlab='ozone Concentration', 
      ylab='no of instances', main='ozone level in NY city',
      col='red')

#Horizontal bar plot
barplot(airquality$Ozone, main='Ozone concenteration in air'
        ,xlab='ozone level', col='red', horiz=FALSE)

#histogram
hist(airquality$Solar.R)
hist(airquality$Solar.R,main='solar radiation value in air'
     ,xlab='solar rad',col='red')


#Box plot
boxplot(airquality$Solar.R)

#multiple box plot
boxplot(airquality[,1:4],main="Multiple", col = 'blue')


#multiple graph at one window

par(mfrow=c(4,4),mar=c(2,5,2,1),las=0,bty='n')
plot(airquality$Ozone,type = 'h')
plot(airquality$Ozone,airquality$Temp)
plot(airquality,type='s')
plot(airquality$Ozone, type='l')
plot(airquality$Ozone, xlab='ozone Concentration', 
     ylab='no of instances', main='ozone level in NY city',
     col='red')
barplot(airquality$Ozone, main='Ozone concenteration in air'
        ,xlab='ozone level', col='red', horiz=FALSE)
hist(airquality$Solar.R)
hist(airquality$Solar.R,main='solar radiation value in air'
     ,xlab='solar rad',col='red')
boxplot(airquality$Solar.R)
boxplot(airquality[,1:4],main="Multiple", col = 'blue')
summary(airquality)



0*0.4+1*0.25+2*0.2+3*0.05+4*01
