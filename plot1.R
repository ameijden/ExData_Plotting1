## This script creates Plot 1

## Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007

## Plot 1: Global_active_power: household global minute-averaged active power (in kilowatt) in this 2-day period
## The data is per minute so we have 48 * 60 = 2880 observations

library(dplyr)

## First step -> get all the data
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
Allneededdata <- filter(Allthedata, V1 >= "2007-02-01" & V1 <= "2007-02-02") ## Uses dplyr

## Are there any NA values or ? values in this dataset -> No
NAinthisset <-is.na(Allneededdata)
table(NAinthisset)

## Naming the columns
namescolumns <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colnames(Allneededdata) <- namescolumns

## Converting the data from Factor to numeric
Allneededdata$Global_active_power <- as.numeric(paste(Allneededdata$Global_active_power)) 


## Creating the png file in the working directory

png(file = "plot1.png")

hist(Allneededdata$Global_active_power, col = "red", main="Globa Active Power", xlab="Globa Active Power (kilowatts)", ylab = "Frequency")

dev.off()
