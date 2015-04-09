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
png(filename = "plot4.png", width = 480, height = 480)

# Plot graph
par(mfrow = c(2, 2))

with(PowerConsumption, {
  ylabel1 <- "Global Active Power"
  plot(PowerConsumption$DateTime, PowerConsumption$Global_active_power, type = "l", xlab = "", ylab = ylabel1)
 
  xlabel2 <- "datetime"
  ylabel2 <- "Voltage"
  plot(PowerConsumption$DateTime, PowerConsumption$Voltage, type = "l", xlab = xlabel2, ylab = ylabel2)
  
  ylabel3 <- "Energy sub metering"
  plot(PowerConsumption$DateTime, PowerConsumption$Sub_metering_1, type = "l", xlab = "", ylab = ylabel3)
  points(PowerConsumption$DateTime, PowerConsumption$Sub_metering_2, type = "l", col = "red")
  points(PowerConsumption$DateTime, PowerConsumption$Sub_metering_3, type = "l", col = "blue")
  
  legend.txt <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  legend.col <- c("black", "red", "blue")
  legend("topright", legend = legend.txt, col = legend.col, lty = 1, lwd = 2)
  
  xlabel4 <- "datetime"
  ylabel4 <- "Global_reactive_power"
  plot(PowerConsumption$DateTime, PowerConsumption$Global_reactive_power, type = "l", xlab = xlabel4, ylab = ylabel4)
  
})

# Close png device
dev.off()
