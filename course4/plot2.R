setwd("/Users/Beeta/Rcodes/datasciencecoursera/course4")
path <- getwd()
filename <- "household_power_consumption.txt"


# from the dates 2007-02-01 and 2007-02-02
# missing value coded as ?

library(tidyverse)
library(data.table)

# PLOT 2

data2 <- data.table::fread(file = filename, sep = ";", na.strings = "?" ) # faster than read csv/table and does not change type
colnames(data2)
str(data2)
head(data2)

# merge date and time, add the col
DateTime <- strptime(paste(data2$Date, data2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") # the type is POSIXlt which is very long and memory consuming
DateTime <- as.POSIXct(DateTime) # so convert it to POSIXct that is more efficient
str(DateTime)
data2 <- cbind(data2, DateTime) # add the col

data2$Date <- as.Date(data2$Date, format="%d/%m/%Y")
data2$Time <- format(data2$Time, format="%H:%M:%S")

subPower <- subset(data2, Date == "2007-02-01" | Date =="2007-02-02")

png("plot2.png", width=480, height=480)
with(subPower, plot(DateTime, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
dev.off()






