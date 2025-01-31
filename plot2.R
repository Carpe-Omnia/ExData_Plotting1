##this is the code to make plot 2
library(dplyr)
library(lubridate)
  
##loading raw data into memory
myRawData <- read.table("./household_power_consumption.txt", sep=";", header = TRUE)
##subsetting raw data by date
myDatedData <- filter(myRawData, Date == "1/2/2007" | Date == "2/2/2007")
##making the frequency numeric so it can be plotted
myDatedData$Global_active_power <- as.numeric(myDatedData$Global_active_power) 
rm(myRawData) ##Removing raw data from memory to save resources

##converting date and time into one usable dateTime object
formattedDate <- strptime(as.character(myDatedData$Date), format="%d/%m/%Y")
dateTime <- as.POSIXct(paste(formattedDate, myDatedData$Time))
print(dateTime[1]) ##had this for debugging purposes

png(file="./plot2.png")
plot(dateTime, myDatedData[,3], type="l", xlab="", ylab="Global Active Power (kilowatts)" )
dev.off()

