setwd("/Users/Beeta/Rcodes/datasciencecoursera/course4")
path <- getwd()
filename <- "household_power_consumption.txt"


# from the dates 2007-02-01 and 2007-02-02
# missing value coded as ?

library(tidyverse)
library(data.table)

# PLOT 3

data3 <- data.table::fread(file = filename, sep = ";", na.strings = "?" ) # faster than read csv/table and does not change type
colnames(data3)
str(data3)
head(data3)

# merge date and time, add the col
DateTime <- strptime(paste(data3$Date, data3$Time, sep=" "), "%d/%m/%Y %H:%M:%S") # the type is POSIXlt which is very long and memory consuming
DateTime <- as.POSIXct(DateTime) # so convert it to POSIXct that is more efficient
str(DateTime)
data3 <- cbind(data3, DateTime) # add the col

data3$Date <- as.Date(data3$Date, format="%d/%m/%Y")
data3$Time <- format(data3$Time, format="%H:%M:%S")

subPower <- subset(data3, Date == "2007-02-01" | Date =="2007-02-02")

png("plot3.png", width=480, height=480)
with(subPower, plot(DateTime, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
lines(subPower$DateTime, subPower$Sub_metering_2,type="l", col= "red")
lines(subPower$DateTime, subPower$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
dev.off()








