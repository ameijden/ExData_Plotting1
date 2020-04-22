## This script creates Plot 4

## Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007
## Plot 4: 4 plots, using plot 2 and plot 3 and creating two new plots, voltage use and global reactive power use during these two days.

library(dplyr)
library(lubridate)

## First step -> get all the data, can be skipped if you already have this data from plot 1, 2 or 3
##Download and unzip the data
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(url, "Allhouseholdpower.zip")
unzip("Allhouseholdpower.zip", exdir = "HouseholdData")

## Read the download data
directory <- getwd()
Allthedata <- read.table(paste0(directory,"/HouseholdData/household_power_consumption.txt"), na.strings = "?", header=FALSE, sep=";", dec = ".")

## Convert Date 
Allthedata$V1 <- as.Date.character(Allthedata$V1, format = c("%d/%m/%Y")) ## Head looks different, orders differently?

## Get only the needed data for this plot.
Allneededdataplot4 <- filter(Allthedata, V1 >= "2007-02-01" & V1 <= "2007-02-02") ## Uses dplyr

## Naming the columns
namescolumns <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colnames(Allneededdataplot4) <- namescolumns

## Converting the data from Factor to numeric
Allneededdataplot4$Global_active_power <- as.numeric(paste(Allneededdataplot4$Global_active_power)) 

Allneededdataplot4$Sub_metering_1 <- as.numeric(paste(Allneededdataplot4$Sub_metering_1)) 
Allneededdataplot4$Sub_metering_2 <- as.numeric(paste(Allneededdataplot4$Sub_metering_2)) 
Allneededdataplot4$Sub_metering_3 <- as.numeric(paste(Allneededdataplot4$Sub_metering_3)) 

Allneededdataplot4$Voltage <- as.numeric(paste(Allneededdataplot4$Voltage)) 
Allneededdataplot4$Global_reactive_power <- as.numeric(paste(Allneededdataplot4$Global_reactive_power)) 


## Creating an extra column to the dataset with combined day and time
Allneededdataplot4 <- mutate(Allneededdataplot3, DT = paste(Date, Time))

## Convert this extra column to a format it can be plotted (using the lubridate library)
Allneededdataplot4$DT <- as_datetime(Allneededdataplot4$DT, tz = "UTC", format = NULL) 


## Creating the png file in the working directory

png(file = "plot4.png")
attach(Allneededdataplot4)
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
plot(DT, Global_active_power, type = "l", xlab="", ylab="Global Active Power")
plot(DT, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(DT, Sub_metering_1, type = "S", col="black", xlab="", ylab="Energy sub metering")
lines(DT, Sub_metering_2, type = "l", col="red")
lines(DT, Sub_metering_3, type = "l", col="blue") 
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=1:1)
plot(DT, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()






