# course 4: exploratory data analysis
# week 1
# course project 1

# ===========================
# Please ignore some extra lines of codes that are commented
# Those are for my learnig purpose
# Thank you1
# ===========================

setwd("/Users/Beeta/Rcodes/datasciencecoursera/course4")
path <- getwd()
filename <- "household_power_consumption.txt"


# from the dates 2007-02-01 and 2007-02-02
# missing value coded as ?

library(tidyverse)
library(data.table)

# PLOT 1

data1 <- data.table::fread(file = filename, sep = ";", na.strings = "?" ) # faster than read csv/table and does not change type
# Classes ‘data.table’ and 'data.frame':	2075259 obs. of  9 variables:
# powerCon <- data.table::fread(filename, cmd = system('grep "2/2/2007" /Users/Beeta/Rcodes/datasciencecoursera/course4/household_power_consumption.txt'), sep = ";", na.strings = "?" ) # faster than read.csv
# system('grep "2/2/2007" /Users/Beeta/Rcodes/datasciencecoursera/course4/household_power_consumption.txt')
# awk
colnames(data1)
str(data1)
head(data1)

# powerCon <- data[data$Date %in% c("1/2/2007", "2/2/2007")]
subPower <- subset.data.frame(data1, Date == "1/2/2007" | Date =="2/2/2007")
str(subPower)
# Classes ‘data.table’ and 'data.frame':	2880 obs. of  9 variables:

png("plot1.png", width = 480, height = 480)
hist(subPower$Global_active_power, col = "red", main = "Global Active Power", xlab="Global Active Power(kilowatts)")
dev.off()


