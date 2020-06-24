
#confidence interval





#using math & cal
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



#using program
#install packages
library(gmodels)
library(nycflights13)
#extrac data
data<-nycflights13::flights

dep_delay<-data$dep_delay
ar_delay<-data$arr_delay
dep_delay1<-dep_delay[!is.na(dep_delay)]
ar_delay1<-ar_delay[!is.na(ar_delay)]
#confidence interval
ci(dep_delay1)
ci(ar_delay1)
