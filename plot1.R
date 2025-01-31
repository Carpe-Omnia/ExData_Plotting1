##this is the code to make plot 1
library(dplyr)
  
##loading raw data into memory
myRawData <- read.table("./household_power_consumption.txt", sep=";", header = TRUE)
##subsetting raw data by date
myDatedData <- filter(myRawData, Date == "1/2/2007" | Date == "2/2/2007")
##making the frequency numeric so it can be plotted
myDatedData$Global_active_power <- as.numeric(myDatedData$Global_active_power) 
rm(myRawData) ##Removing raw data from memory to save resources

##explicitly open the graphics device  
png(file="./plot1.png")
##plot the histogram to the graphics device
hist(myDatedData$Global_active_power, main="Global Active power", col="red",xlab="Global Active Power (kilowatts)")
##explicity close the graphics device
dev.off()
  