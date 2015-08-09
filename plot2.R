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
FileName <- "plot2.png"
if (file.exists(FileName)) {file.remove(FileName)}

## Output plot to PNG format
png(filename = FileName, height = 480, width = 480)
plot(df_subset$Global_active_power ~ df_subset$DateTime,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

## Set output device to null
while (dev.cur() > 1) {dev.off()}
