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
df$strDate <- as.Date(df$Date,"%d/%m/%Y")

## Extract data subset
df_subset <- df[df$strDate == "2007-02-01" | df$strDate == "2007-02-02",]
#df_subset <- subset(df, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

## Remove original data to free up memory
rm(df)

## Convert data to numeric
df_subset$Global_active_power <- as.numeric(df_subset$Global_active_power)

## Display the structure of the data subset
str(df_subset)

## Output plot to PNG
png(filename = "plot1.png", width = 480, height = 480)
hist(df_subset$Global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()
