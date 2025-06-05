data <- read.table("C:/Users/ovezina/Downloads/household_power_consumption.txt",
                   header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subsetdata <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
subsetdata$DateTime <- as.POSIXct(paste(subsetdata$Date, subsetdata$Time), 
                                  format = "%Y-%m-%d %H:%M:%S")

subsetdata <- subsetdata[complete.cases(subsetdata[, c("DateTime", "Global_active_power")]), ]

png("plot1.png", width=480, height=480)
hist(subsetdata$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()