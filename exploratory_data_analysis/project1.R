#Reconstruct plots using base plotting in R
setwd("C:/Users/aidan/data_science/datasciencecoursera/exploratory_data_analysis")
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", skip=66636, nrow=2880, col.names=colnames(read.table("household_power_consumption.txt", nrow=1,header=TRUE,sep=";")))
colnames(power) <- tolower(colnames(power))

#make the first plot
png(filename="plot1.png", width=480, height=480)
hist(power$global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()

#make the second plot
library(lubridate)
power$dt <- paste(power$date, power$time, sep=" ")
power$dt <- dmy_hms(power$dt)
png(filename="plot2.png", width=480, height=480)
plot(power$dt, power$global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

#make the third plot
png(filename="plot3.png", width=480, height=480)
plot(power$dt, power$sub_metering_1, type="l", xlab="", ylab="Energy sub metering", )
lines(power$dt, power$sub_metering_2, type="l", col="red")
lines(power$dt, power$sub_metering_3, type="l", col="blue")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("sub_metering_1", "sub_metering_2", "sub_metering_3"))
dev.off()

#make the fourth plot
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
#1 
plot(power$dt, power$global_active_power, type="l", xlab="", ylab="Global Active Power")
#2
plot(power$dt, power$voltage, type="l", xlab="datetime", ylab="Voltage")
#3
plot(power$dt, power$sub_metering_1, type="l", xlab="", ylab="Energy sub metering", )
lines(power$dt, power$sub_metering_2, type="l", col="red")
lines(power$dt, power$sub_metering_3, type="l", col="blue")
legend("topright", bty="n", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("sub_metering_1", "sub_metering_2", "sub_metering_3"))
#4
plot(power$dt, power$global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power",)
axis(2, c(0.1, 0.2, 0.3, 0.4, 0.5), c(0.1, 0.2, 0.3, 0.4, 0.5))
dev.off()
