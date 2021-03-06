## Loading the libraries which is already installed with install.packages command
install.packages("dplyr")
library(dplyr)
library(data.table)
## Downloaded the compressed  file 

if(!file.exists("./Electric power consumption")){dir.create("./Electric power consumption")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./Electric power consumption/exdata-data-household_power_consumption.zip")
## uncompress the file
unzip(zipfile="./Electric power consumption/exdata-data-household_power_consumption.zip",exdir="./Electric power consumption")
## List the files
path_rf <- file.path("./Electric power consumption")
files<-list.files(path_rf, recursive=TRUE)
files

## Reading  file
dataHouseholdPower  <- fread(file.path(path_rf, "household_power_consumption.txt" ),stringsAsFactors=FALSE, na.strings = "?")
## Subset for the dates 01/02/2007 & 02/02/2007
subsetData <- filter(dataHouseholdPower, grep("^[1,2]/2/2007", Date))

##   plot 3 -- line plot file for sub metering 1,2 & 3 vs day of week
## create a datetime by combining both date and time
subsetData$timestamp <- paste(subsetData$Date,subsetData$Time)
subsetData$Sub_metering_1 <- as.numeric(subsetData$Sub_metering_1)
subsetData$Sub_metering_2 <- as.numeric(subsetData$Sub_metering_2)
subsetData$Sub_metering_3 <- as.numeric(subsetData$Sub_metering_3)

plot(strptime(subsetData$timestamp, format="%d/%m/%Y %H:%M:%S"),xlab= "",ylab= "Energy sub metering", subsetData$Sub_metering_1, type = "l")
lines(strptime(subsetData$timestamp, format="%d/%m/%Y %H:%M:%S"), subsetData$Sub_metering_2, type = "l",col="red")
lines(strptime(subsetData$timestamp, format="%d/%m/%Y %H:%M:%S"), subsetData$Sub_metering_3, type = "l",col="blue")
legend("topright", lty= 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!

## end