# Global Settings

## Setting working directory where the data is located. (Replace as needed)
setwd("/Volumes/HP x755w/Coursera/Exploratory_Data_Analysis/Project1")

# Read the dataset 
# Dataset: Electric power consumption [20Mb]
# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#  
#  Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

## Remember the NA are represented as "?"

base_data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Change the format date to actual Date Type

base_data$Date <- as.Date(base_data$Date, "%d/%m/%Y")

## The dataset es quite big and we are only going to use a subset of dates, so first we will subset it

# Subset  data between Feb. 1, 2007 and Feb. 2, 2007
base_data <- subset(base_data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Remove the incomplete observations
base_data <- base_data[complete.cases(base_data),]

# we need date and time on the same field, so we will need to combine Date and Time into a single column
dateTime <- paste(base_data$Date, base_data$Time)

# and add its Name
dateTime <- setNames(dateTime, "DateTime")

# Just to tidy up we will remove the Date and Time original columns and add the new column DateTime
base_data <- base_data[ ,!(names(base_data) %in% c("Date","Time"))]
base_data <- cbind(dateTime, base_data)
base_data$dateTime <- as.POSIXct(dateTime) #format the dateTime column


# Actual Plotting (it must be done using only base package)
## We will put all the plots here and then split the files as needed per the subsimmsion requirements

# PLOT 4 - Version 1 (First Screen then copy to PNG)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(base_data, {
  plot(Global_active_power ~ dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage ~ dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1 ~ dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2 ~ dateTime,col='Red')
  lines(Sub_metering_3 ~ dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
## Copy to PNG (480 x 480) and close device  
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off() 



# PLOT 4 - Version 2 (Directly to PNG)
# open device  
png(filename = './plot4.png', width = 480, height = 480, units='px')  
# plot figure 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(base_data, {
  plot(Global_active_power ~ dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage ~ dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1 ~ dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2 ~ dateTime,col='Red')
  lines(Sub_metering_3 ~ dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
# close device
dev.off() 








