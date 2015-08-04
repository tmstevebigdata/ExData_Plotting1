# Clear workspace
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

## Convert data to numeric
df_subset$Global_active_power <- as.numeric(df_subset$Global_active_power)

## Convert date & time to POSIX format
POSIX_datetime <- paste(as.Date(df_subset$Date), df_subset$Time)
df_subset$Datetime <- as.POSIXct(POSIX_datetime)

## Display the structure of the data subset
str(df_subset)

## Output plot to PNG
png(filename = "plot2.png", width = 480, height = 480)
plot(df_subset$Global_active_power ~ df_subset$Datetime,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
