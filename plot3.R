## This script creates Plot 3

## Step 1: Read the data
## Step 2: First create the local plot
## Step 3: Set the labels
## Step 4: Create the PNG file

## Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007

## Plot 3: Energy sub metering values during these two days

library(dplyr)
library(lubridate)

## First step -> get all the data, can be skipped if you already have this data from plot 1
##Download and unzip the data
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(url, "Allhouseholdpower.zip")
unzip("Allhouseholdpower.zip", exdir = "HouseholdData")


## Read the download data
directory <- getwd()
Allthedata <- read.table(paste0(directory,"/HouseholdData/household_power_consumption.txt"), na.strings = "?", header=FALSE, sep=";", dec = ".")

## Convert Date 
Allthedata$V1 <- as.Date.character(Allthedata$V1, format = c("%d/%m/%Y")) ## Head looks different, orders differently?

## Get only the needed data 
Allneededdataplot3 <- filter(Allthedata, V1 >= "2007-02-01" & V1 <= "2007-02-02") ## Uses dplyr

## Naming the columns
namescolumns <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colnames(Allneededdataplot3) <- namescolumns

## Converting the data from Factor to numeric, would be nicer to do this for all columns whic should be numeric (V3 .. V9)
Allneededdataplot3$Global_active_power <- as.numeric(paste(Allneededdataplot3$Global_active_power)) 

Allneededdataplot3$Sub_metering_1 <- as.numeric(paste(Allneededdataplot3$Sub_metering_1)) 
Allneededdataplot3$Sub_metering_2 <- as.numeric(paste(Allneededdataplot3$Sub_metering_2)) 
Allneededdataplot3$Sub_metering_3 <- as.numeric(paste(Allneededdataplot3$Sub_metering_3)) 

## Creating an extra column to the dataset with combined day and time
Allneededdataplot3 <- mutate(Allneededdataplot3, DT = paste(Date, Time))

## Convert this extra column to a format it can be plotted (using the lubridate library)
Allneededdataplot3$DT <- as_datetime(Allneededdataplot3$DT, tz = "UTC", format = NULL) ## Looks correct, library lubridate


## Creating the png file in the working directory

png(file = "plot3.png")
with(Allneededdataplot3, plot(DT, Sub_metering_1, type = "S", col="black", xlab="", ylab="Energy sub metering"))
lines(Allneededdataplot3$DT, Allneededdataplot3$Sub_metering_2, type = "l", col="red")
lines(Allneededdataplot3$DT, Allneededdataplot3$Sub_metering_3, type = "l", col="blue")  
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=1:1)
dev.off()


