
##this is the code to make plot 4. A combination of the previous plots and a few new ones
library(dplyr)
library(lubridate)

##loading raw data into memory
myRawData <- read.table("./household_power_consumption.txt", sep=";", header = TRUE)
##subsetting raw data by date
myDatedData <- filter(myRawData, Date == "1/2/2007" | Date == "2/2/2007")
rm(myRawData) ##Removing raw data from memory to save resources

##Formatting data into a usable form for plotting. Probably a more elegant way to do this
myDatedData$Global_active_power <- as.numeric(myDatedData$Global_active_power) 
myDatedData$Voltage <- as.numeric(myDatedData$Voltage) 
myDatedData$Sub_metering_1 <- as.numeric(myDatedData$Sub_metering_1) 
myDatedData$Sub_metering_2 <- as.numeric(myDatedData$Sub_metering_2)
myDatedData$Sub_metering_3 <- as.numeric(myDatedData$Sub_metering_3)
myDatedData$Global_reactive_power <- as.numeric(myDatedData$Global_reactive_power) 

##Fotmatting Date & Time to be usable for plotting
formattedDate <- strptime(as.character(myDatedData$Date), format="%d/%m/%Y")
dateTime <- as.POSIXct(paste(formattedDate, myDatedData$Time))


##Getting ready to make the plots
png(file="./plot4.png") ##explicitly open the graphics device  
par(mfrow=c(2,2)) ##setting up for four plots

##Actually Making the plots
plot(dateTime, myDatedData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)" )

plot(dateTime, myDatedData$Voltage, type="l", xlab="", ylab="Voltage" )

plot(dateTime,myDatedData$Sub_metering_1, type="l", col="black", ylab="Energy Sub Metering", xlab="")
lines(dateTime, myDatedData$Sub_metering_2, type="l", col="red") ##adding sub_metering2
lines(dateTime, myDatedData$Sub_metering_3, type="l", col="blue") ##adding sub_metering3
subMeteringTextVector <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend(x="topright", legend=subMeteringTextVector, col=c("black", "red", "blue"), lty=c(1,1,1))

plot(dateTime, myDatedData$Global_reactive_power, type="l", xlab="", ylab="Global_reactive_power")

##explicity close the graphics device
dev.off()
