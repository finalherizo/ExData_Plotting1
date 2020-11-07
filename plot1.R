## Week 1 exploratory analysis
## plot1.R

# Set wd
currWd <- getwd()
setwd(dirname(sys.frame(1)$ofile))

if (!file.exists("./data")) {
        dir.create("./data");
}

dataset.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataset.name <- "./data/household_power_consumption.zip"
dataset.filename <- "./data/household_power_consumption.txt"

if (!file.exists(dataset.name)) {
        download.file(url = dataset.url, destfile = dataset.name);
}

if (!file.exists(dataset.filename)) {
        unzip(zipfile = dataset.name, exdir = "./data")
}

## Load data
library(dplyr)
library(lubridate)
dataset.colnames <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                      "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                      "Sub_metering_3")
dataset.frame <- read.csv(file = dataset.filename, skip = 66636, nrows = 2880, sep = ";",
                          col.names = dataset.colnames, na.strings = "?") %>%
        as_tibble %>%
        mutate(Time = dmy_hms(paste(Date, Time)), Date = dmy(Date)) %>%
        print

# Plot Global active power
par(mfrow = c(1, 1))
with(dataset.frame, 
     hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.copy(png, "plot1.png")
dev.off()

# Reset curdir
setwd(currWd)
