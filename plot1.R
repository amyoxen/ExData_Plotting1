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

# Plot the Graph
with(selectData, hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (Kilowatts)", col="#f00000"))

#Copy the image to "Plot1.png"
dev.copy(png,file="plot1.png")
dev.off()

