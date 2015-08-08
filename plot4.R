## Clear workspace
rm(list=ls())
ls()

## Set working directory
setwd("E:/Big Data Course/Module 4 - Exploratory Data Analysis/Course Project 1")
getwd()

## Load library
library(data.table)

## Read the data file
df <- fread("household_power_consumption.txt", na.strings = "?")

## Set date format to d:m:y
df$Date <- as.Date(df$Date, "%d/%m/%Y")

## Extract data subset
df_subset <- subset(df, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Remove original data to free up memory
rm(df)

## Convert date & time to POSIX format
POSIX_datetime <- paste(as.Date(df_subset$Date), df_subset$Time)
df_subset$Datetime <- as.POSIXct(POSIX_datetime)

## Display the structure of the data subset
str(df_subset)

## Output plot to PNG
FileName <- "plot4.png"
if (file.exists(FileName)) {file.remove(FileName)}

png(filename = FileName, height = 480, width = 480)
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(df_subset, {
     plot(Global_active_power~Datetime,
          type = "l",
          xlab = "",
          ylab = "Global Active Power")

     plot(Voltage ~ Datetime,
          type = "l",
          xlab = "datetime",
          ylab = "Voltage")

     plot(Sub_metering_1 ~ Datetime,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering")
          lines(Sub_metering_2~Datetime, col = 'Red')
          lines(Sub_metering_3~Datetime, col = 'Blue')
          legend("topright", col = c("black", "red", "blue"),
                  lty = 1,
                  lwd = 2,
                  bty = "n",
                  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 1)

     plot(Global_reactive_power ~ Datetime,
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power")
})
dev.off()
