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

# plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mar = c(5, 4, 2, 1), mfrow = c(2,2))
# upper left plot
with(hhp, plot(DateT, Global_active_power, type="l",
  xlab = "", ylab = "Global Active Power (kilowatts)", cex.lab = 0.7))
# upper right plot
with(hhp, plot(DateT, Voltage, type="l",
  xlab = paste(firstDate,"to",secondDate),
  ylab = "Voltage", cex.lab = 0.7))
# lower left plot
plot(hhp$DateT, hhp$Sub_metering_1, type="n",
  xlab = "", ylab = "Energy sub metering", cex.lab = 0.7)
  colors <- c("black", "red", "blue")
  lines(hhp$DateT, hhp$Sub_metering_1, col = colors[1])
  lines(hhp$DateT, hhp$Sub_metering_2, col = colors[2])
  lines(hhp$DateT, hhp$Sub_metering_3, col = colors[3])
  cex = 0.9
  legend("topright", lty = 1, col = colors, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# lower right plot
with(hhp, plot(DateT, Global_reactive_power, type="l",
  xlab = paste(firstDate,"to",secondDate),
  ylab = "Global Reactive Power", cex.lab = 0.7))
par(mfrow = c(1,1), mar = c(5, 4, 4, 2))
dev.off()
