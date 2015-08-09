## Clear workspace
rm(list=ls())
ls()

## Set working directory
setwd("E:/Big Data Course/Module 4 - Exploratory Data Analysis/Course Project 1")
getwd()

## Load library
library(data.table)

## Read the data file and remove all NAs
df <- fread("household_power_consumption.txt", na.strings = "?")
na.omit(df)

## Set Date in df to date format
df$Date <- as.Date(df$Date,"%d/%m/%Y")

## Extract data subset
df_subset <- subset(df, subset = (df$Date >= "2007-02-01" & df$Date <= "2007-02-02"))

## Remove original data to free up memory
rm(df)

## Convert data to numeric
df_subset$Global_active_power <- as.numeric(df_subset$Global_active_power)
df_subset$Global_reactive_power <- as.numeric(df_subset$Global_reactive_power)

## Display the structure of the data subset
str(df_subset)

## Convert Date & Time to POSIX format and add new DateTime column to df_subset
POSIX_datetime <- paste(as.Date(df_subset$Date), df_subset$Time)
df_subset$DateTime <- as.POSIXct(POSIX_datetime)

## Display the structure of the data subset
str(df_subset)

## -- Output plot --
## Set output device to null
while (dev.cur() > 1) {dev.off()}

## Set plot name
FileName <- "plot4.png"
if (file.exists(FileName)) {file.remove(FileName)}

## Output plot to PNG format
png(filename = FileName, height = 480, width = 480)
par(mfrow = c(2, 2), mar = c(4,4,2,1), oma = c(0,0,2,0)) ## Set 4 plots in 1 (2 rows x 2 columns) - Display by row then by column
with(df_subset, {
     plot(Global_active_power ~ DateTime,
          type = "l",
          xlab = "",
          ylab = "Global Active Power")

     plot(Voltage ~ DateTime,
          type = "l",
          xlab = "datetime",
          ylab = "Voltage")

     plot(Sub_metering_1 ~ DateTime,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering")
          lines(Sub_metering_1 ~ DateTime, col = "Black")
          lines(Sub_metering_2 ~ DateTime, col = "Red")
          lines(Sub_metering_3 ~ DateTime, col = "Blue")
          legend("topright",
                 col = c("Black", "Red", "Blue"),
                 lty = 1,
                 lwd = 2,
                 bty = "n",
                 legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 1)

     plot(Global_reactive_power ~ DateTime,
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power")
})

## Set output device to null
while (dev.cur() > 1) {dev.off()}
