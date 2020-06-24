#airquality=read.csv
#In R Console extract data set

airquality<-datasets::beaver2

head(beaver2) #Run
tail(beaver2) #Run
beaver2$time #Run

#descriptive_stat
#It's show's median, mean, min, max
summary(beaver2$time)
summary(beaver2$temp)
summary(beaver2$activ)

#Ploat
plot(beaver2$temp)
plot(beaver2$temp,beaver2$time)
plot(beaver2) #Its scatter plot graph
summary(beaver2)

#point' and Line
plot(beaver2$Ozone, type='l')
plot(beaver2$Ozone, xlab='ozone Concentration', 
     ylab='no of instances', main='ozone level in NY city',
     col='red')

#Horizontal bar plot
barplot(beaver2$Ozone, main='Ozone concenteration in air'
        ,xlab='ozone level', col='red', horiz=FALSE)

#histogram
hist(beaver2$Solar.R)
hist(beaver2$Solar.R,main='solar radiation value in air'
     ,xlab='solar rad',col='red')


#Box plot
boxplot(beaver2$Solar.R)

#multiple box plot
boxplot(beaver2[,1:4],main="Multiple", col = 'blue')


#multiple graph at one window

par(mfrow=c(4,4),mar=c(2,5,2,1),las=0,bty='n')
plot(beaver2$temp)
plot(beaver2$temp,beaver2$time)
plot(beaver2) #Its scatter plot graph
summary(beaver2)
plot(beaver2$temp, type='l')
plot(beaver2$tempe, xlab='temp Concentration', 
     ylab='no of instances', main='ozone level in NY city',
     col='red')
barplot(beaver2$Ozone, main='Ozone concenteration in air'
        ,xlab='ozone level', col='red', horiz=FALSE)
hist(beaver2$Solar.R)
hist(beaver2$Solar.R,main='solar radiation value in air'
     ,xlab='solar rad',col='red')
boxplot(beaver2$Solar.R)
boxplot(beaver2[,1:4],main="Multiple", col = 'blue')
