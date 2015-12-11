###  BEGIN SCRIPT
### NAME OF SCRIPT:  plot3.R
### DESCRIPTION:  This script is used to perform analysis on the data collected
##  from the household_power_consumption text file containing individual
##  household consumption data.
### AUTHOR: Gloria Jackson
### DATE:   December 10, 2015

## set working directory
## NOTE: set working directory prior to executing script

##  load libraries
library(data.table)
library(dplyr)
library(datasets)

##  read input data file ####
epcdata <- data.table(read.delim("household_power_consumption.txt", header = TRUE, na.strings = "?",sep = ";"))

## subset only the data for February 1 and February 2 2007
epcd1 <- filter(epcdata[epcdata$Date == "1/2/2007" | epcdata$Date == "2/2/2007",])

## Combine the date and time into one variable and rename the variable to 'Day'
epcd1 <- data.table(epcd1,paste(epcd1$Date,epcd1$Time))
epcd1 <- rename(epcd1, Day = V2)

## write a new data table converting the 'Day' variable from char to time, 
## exclude the individual 'Date' and 'Time' variables because the value is stored in'Day'
epcd3 <- data.table(strptime(epcd1$Day, format = "%d/%m/%Y %H:%M:%S"),
                    + epcd1$Global_active_power,epcd1$Global_reactive_power,
                    + epcd1$Voltage,epcd1$Global_intensity,epcd1$Sub_metering_1,
                    + epcd1$Sub_metering_2,epcd1$Sub_metering_3,na.strings = "?",na.rm=TRUE)

## rename the generic variable names to meaningful variable names
epcd3 <- rename(epcd3, Day = V1)
epcd3 <- rename(epcd3, Global_active_power = V2,Global_reactive_power = V3)
epcd3 <- rename(epcd3, Voltage = V4,Global_intensity = V5)
epcd3 <- rename(epcd3, Sub_metering_1 = V6,Sub_metering_2 = V7, Sub_metering_3 = V8)

## widen right margin
par(mar=c(5,4,4,6))

###  Plot the histogram on Screen
plot(epcd3$Day,epcd3$Sub_metering_1,col="gray",
       type = "l", xlab = "",ylab = "Energy sub metering")
points(epcd3$Day,epcd3$Sub_metering_2,col="red",type = "l")
points(epcd3$Day,epcd3$Sub_metering_3,col="blue",type = "l")
legend("topright",lty=1,lwd=2.5,cex=.6,col=c("gray","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Copy the histogram to a PNG file with width and height of 480
dev.copy(png,file = "plot3.png",width = 480, height = 480)   

## Close the PNG device
dev.off()                                        



