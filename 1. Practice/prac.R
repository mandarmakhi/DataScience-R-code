1+1
2+3*4
3^2
exp(1)
sqrt(10)
pi
2*pi*6378
x<-3 
y<-10
z<-15
x*y*z
X*Y*Z
This.Year<-2004
This.Year

#vector constructing
vect<-c(1,2,3,4,5)
rep(1,10)
seq(2,6)
seq(4,20,by=4)
x*y
sqrt(x)
y[4]
x[1]
X<-c(2,0,0,4)
x[1]
x[-1]
x[1]<-3;x
x[-1]<-5;x
y[4]=1
y<9
y[y<9]=2
y
df<-data.frame(x=1:3,y=c("a","b","c"))
data.frame(height=c(150,160),weight=c(65,72))
df
df[1,c(1,2)]
df[b]
c(b)
df[b]
df<-data.frame(x=1:3,y=c("1","2","3"))
df<-c(1,2,3,"1","2","3")
a<-c(1,2,3)
b<-c("1","2","3")
mean(a)
mean(b)
df
df[3,]
df[,2]


#continous normal distribution 
pnorm(70,60,10)
pnorm(60,60,150)

#p(697<= X <= 740) ?
pnorm(697,711,29)

#infanential statistics

#confidence interval
1990-1.645*2500/11.83 #min
1990+1.645*2500/11.83 #max

#for z-1.645 (90%)
##95% confidence leve given find z
#0.95=0.975
#100%-95%=5%
#5%/2=2.5%
#95+2.5=97.5=0.975
qnorm(0.975)
#1.9599654 answer

#finding T using qt command(z value,sample-1)
qt(0.975,139)
#T value 1.9771
1900+1.9771*2833/11.83
1900-1.9771*2833/11.83

qt(.975,15)

29.1875-2.131*16/3.872

29.1875+2.131*16/3.872



library(gmodels)
library(nycflights13)
data<-nycflights13::flights
dep_delay<-data$dep_delay
ar_delay<-data$arr_delay
dep_delay1<-dep_delay[!is.na(dep_delay)]
ar_delay1<-ar_delay[!is.na(ar_delay)]
ci(dep_delay1)
ci(ar_delay1)
