#!/usr/bin/Rscript

## Author: Jakub 'Eremiell' Marek
## Written: 2014/08/07

## Usage: "Rscript plot2.R"   (from bash)
##        "./plot2.R"         (from bash, with execute permission)
##        "source("plot2.R")" (from R)

## Plots a graph of global active power in time from household power
## consumption dataset during 1st and 2nd of February 2007 to plot2.png file.

if (!file.exists("household_power_consumption.txt")) {
	download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", "curl")
	unzip("household_power_consumption.zip")
}

dat <- read.csv2("household_power_consumption.txt", as.is = TRUE, stringsAsFactors = FALSE, na.strings = "?")
dat$Time <- paste(dat$Date, dat$Time)
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")
dat <- dat[dat$Date >= as.Date("2007-02-01", format = "%Y-%m-%d") & dat$Date <= as.Date("2007-02-02", format = "%Y-%m-%d"),]
dat$Time <- strptime(dat$Time, format = "%d/%m/%Y %H:%M:%S")
for (i in 3:9) {
	dat[,i] <- as.numeric(dat[,i])
}

png("plot2.png", bg = "transparent")

plot(dat$Time, dat$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()
