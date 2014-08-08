# Exploratory Data Analysis, Project 1
# August 2014
# Dennis Noren

library("lubridate")
setwd("~/Documents/R/eda/ExData_Plotting1")
# unzip and read data
fileinfo <- unzip("exdata-data-household_power_consumption.zip", list=TRUE)
unzip("exdata-data-household_power_consumption.zip")
hhp <- read.table(fileinfo$Name, sep = ";", header = T,
                    colClasses = "character", na.strings = "?")

# process date/time and restrict to days of interest
hhp$DateT <- paste(hhp$Date, hhp$Time)
hhp$DateT <- dmy_hms(hhp$DateT)
hhp$Date <- dmy(hhp$Date)
hhp$Time <- hms(hhp$Time)
firstDate <- dmy("01/02/2007")
secondDate <- dmy("02/02/2007")
hhp <- hhp[hhp$Date %in% c(firstDate:secondDate),]

# convert numeric variables
for (var in c(3:9)) {
  hhp[,var] <- as.numeric(hhp[,var])
}

# plot 1
png(filename = "plot1.png", width = 480, height = 480)
par(mar = c(5, 4, 2, 1))
hist(hhp$Global_active_power, col = "red", main = "Global Active Power",
     cex.main = 0.9, xlab = "Global Active Power (kilowatts)")
par(mar = c(5, 4, 4, 2))
dev.off()
