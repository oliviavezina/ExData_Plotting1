data <- read.table("C:/Users/ovezina/Downloads/household_power_consumption.txt",
                   header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subsetdata <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
subsetdata$DateTime <- as.POSIXct(paste(subsetdata$Date, subsetdata$Time), 
                                  format = "%Y-%m-%d %H:%M:%S")

subsetdata <- subsetdata[complete.cases(subsetdata[, c("DateTime", "Global_active_power")]), ]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(subsetdata$DateTime, subsetdata$Global_active_power, type="l",
     xlab="", ylab="Global Active Power", xaxt = "n")
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

plot(subsetdata$DateTime, subsetdata$Voltage, type="l",
     xlab="datetime", ylab="Voltage", xaxt = "n")
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

plot(subsetdata$DateTime, subsetdata$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering", xaxt = "n")
lines(subsetdata$DateTime, subsetdata$Sub_metering_2, col="red")
lines(subsetdata$DateTime, subsetdata$Sub_metering_3, col="blue")
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))
legend("topright", col=c("black", "red", "blue"), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

plot(subsetdata$DateTime, subsetdata$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global Reactive Power", xaxt = "n")
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

dev.off()