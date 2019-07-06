setwd("/Users/Beeta/Rcodes/datasciencecoursera/course4")
path <- getwd()
filename <- "household_power_consumption.txt"


# from the dates 2007-02-01 and 2007-02-02
# missing value coded as ?

library(tidyverse)
library(data.table)

# PLOT 4

data4 <- data.table::fread(file = filename, sep = ";", na.strings = "?" ) # faster than read csv/table and does not change type
colnames(data4)
str(data4)
head(data4)

# merge date and time, add the col
DateTime <- strptime(paste(data4$Date, data4$Time, sep=" "), "%d/%m/%Y %H:%M:%S") # the type is POSIXlt which is very long and memory consuming
DateTime <- as.POSIXct(DateTime) # so convert it to POSIXct that is more efficient
str(DateTime)
data4 <- cbind(data4, DateTime) # add the col

data4$Date <- as.Date(data4$Date, format="%d/%m/%Y")
data4$Time <- format(data4$Time, format="%H:%M:%S")

subPower <- subset(data4, Date == "2007-02-01" | Date =="2007-02-02")

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subPower, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(subPower, plot(DateTime, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(subPower, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subPower$DateTime, subPower$Sub_metering_2,type="l", col= "red")
lines(subPower$DateTime, subPower$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(subPower, plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()







