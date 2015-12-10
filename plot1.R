###  BEGIN SCRIPT
### NAME OF SCRIPT:  plot1.R
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
epcsubset <- filter(epcdata[epcdata$Date == "1/2/2007" | epcdata$Date == "2/2/2007",])

###  Plot the histogram on Screen
hist(epcsubset$Global_active_power,main = "Global Active Power",col = "red",xlab = "Global Active Power (kilowatts)")      

## Copy the histogram to a PNG file
dev.copy(png,file = "plot1.png",width = 480, height = 480)   

## Close the PNG device
dev.off()                                        



