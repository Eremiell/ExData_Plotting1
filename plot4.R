#!/usr/bin/Rscript

## Author: Jakub 'Eremiell' Marek
## Written: 2014/08/07

## Usage: "Rscript plot4.R"   (from bash)
##        "./plot4.R"         (from bash, with execute permission)
##        "source("plot4.R")" (from R)

## Plots graphs of global active power, energy sub meters, voltage and global
## reactive power in time from household power consumption dataset during 1st
## and 2nd of February 2007 to plot4.png file.

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

png("plot4.png", bg = "transparent")
par(mfcol = c(2, 2))

plot(dat$Time, dat$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(dat$Time, dat$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(dat$Time, dat$Sub_metering_2, col = "#fb0007")
lines(dat$Time, dat$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "#fb0007", "blue"), legend = names(dat)[7:9], lty = "solid", bty = "n")

plot(dat$Time, dat$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(dat$Time, dat$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()

## Notes: Color #fb0007 found using graphic editor (GIMP 2.8.10) on reference
## plot. Doesn't seem to be defined in colors.
## See: http://research.stowers-institute.org/efg/R/Color/Chart/
