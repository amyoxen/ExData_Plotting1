# read the data from the source

Sys.setlocale("LC_TIME", "English")
library(utils)
library(dplyr)
download.file ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "hpc.zip")
downLoadedDate<-date()
downLoadedDate

# read table from the data
tempFile <-unzip("hpc.zip")
data <- read.csv(tempFile, header= TRUE, sep =";", na.strings = c("?",""), colClass=c("character","character",rep("numeric",7)))

# Select the subset of data with date on "2/1/2007" and "2/2/2007"
selectData<- filter(data, Date=="1/2/2007"|Date =="2/2/2007")

# Organize the Date_Time column

selectData$Date_Time<-as.POSIXct(strptime(paste(selectData$Date, selectData$Time, sep=" "), format="%d/%m/%Y %H:%M:%S"))

# Arrange the grid
par(mfcol=c(2,2))
par(mar=c(3,5,3,5))

# Plot the 1st Graph
with(selectData, plot(Date_Time, Global_active_power,type="l",xlab ="", ylab = "Global Active Powers"))

# Plot the 2nd Graph
with(selectData, plot(Date_Time, Sub_metering_1, type="n",xlab ="", ylab = "Energy sub metering"))
with(selectData, points(Date_Time, Sub_metering_1, col = "black", type = "l"))
with(selectData, points(Date_Time, Sub_metering_2, col = "red", type = "l"))
with(selectData, points(Date_Time, Sub_metering_3, col = "blue", type = "l"))
legend("topright", lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")

# Plot the 3rd Graph
with(selectData, plot(Date_Time, Voltage,type="l", xlab ="datetime", ylab = "Voltage"))

# Plot the 4td Graph
with(selectData, plot(Date_Time, Global_reactive_power, type="l",xlab ="datetime", ))

#Copy the image to "Plot4.png"
dev.copy(png,file="plot4.png")
dev.off()
