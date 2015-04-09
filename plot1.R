# Create data directory
if (!file.exists("data")) {
  dir.create("data")
}

# Get the file from internet
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileDestination <- "./data/household_power_consumption.zip"
download.file(fileUrl, destfile = fileDestination, method = "curl")
# Unzip file
unzip(fileDestination, exdir = "./data")

dateDownloaded <- date()
dateDownloaded

# Load data into R
colFormat <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
PowerConsumption <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", colClasses = colFormat, na.strings = "?")

PowerConsumption$DateTime <- paste(PowerConsumption$Date, PowerConsumption$Time)
PowerConsumption$DateTime <- strptime(PowerConsumption$DateTime, "%d/%m/%Y %H:%M:%S")

# Subset data
selection <- (PowerConsumption$DateTime >= "2007-02-01" & PowerConsumption$DateTime < "2007-02-03")
PowerConsumption <- subset(PowerConsumption, selection == TRUE)

# Open png device
png(filename = "plot1.png", width = 480, height = 480)

# Plot graph
title <- "Global Active Power"
xlabel <- "Global Active Power (kilowatts)"
hist(PowerConsumption$Global_active_power, breaks = 24, main = title, xlab = xlabel, col = "red")

# Close png device
dev.off()
