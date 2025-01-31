  ##this is the code to make plot 3
  library(dplyr)
  library(lubridate)
  
  ##loading raw data into memory
  myRawData <- read.table("./household_power_consumption.txt", sep=";", header = TRUE)
  ##subsetting raw data by date
  myDatedData <- filter(myRawData, Date == "1/2/2007" | Date == "2/2/2007")
  rm(myRawData) ##Removing raw data from memory to save resources
  
  ##making the sub metering data numeric so it can be plotted
  myDatedData$Sub_metering_1 <- as.numeric(myDatedData$Sub_metering_1) 
  myDatedData$Sub_metering_2 <- as.numeric(myDatedData$Sub_metering_2)
  myDatedData$Sub_metering_3 <- as.numeric(myDatedData$Sub_metering_3)
  
  
  ##converting date and time into one usable dateTime object
  formattedDate <- strptime(as.character(myDatedData$Date), format="%d/%m/%Y")
  dateTime <- as.POSIXct(paste(formattedDate, myDatedData$Time))
  print(dateTime[1]) ##had this for debugging purposes
  

  png(file="./plot3.png") ##eplicity launch graphics device
  plot(dateTime,myDatedData$Sub_metering_1, type="l", col="black", ylab="Energy Sub Metering", xlab="")
  lines(dateTime, myDatedData$Sub_metering_2, type="l", col="red") ##adding sub_metering2
  lines(dateTime, myDatedData$Sub_metering_3, type="l", col="blue") ##adding sub_metering3
  subMeteringTextVector <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  legend(x="topright", legend=subMeteringTextVector, col=c("black", "red", "blue"), lty=c(1,1,1))
  dev.off() ##explicity close graphics device
