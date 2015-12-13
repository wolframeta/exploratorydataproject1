dataset <- read.csv("./household_power_consumption.txt", sep = ";")

dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")


install.packages("chron")
library(chron)
?chron
dataset$Time <- chron(times= dataset$Time)

trimdata <- subset(dataset, Date == "2007-02-01" | Date == "2007-02-02")

?plot
trimdata$day <- weekdays(as.Date(trimdata$Date))
trimdata$day
head(trimdata)
trimdata$datetime <- paste(trimdata$Date, trimdata$Time, sep = " ")
head(trimdata$datetime)

trimdata$datetime <- strptime(trimdata$datetime, format = "%Y-%m-%d %H:%M:%S")
x <- as.numeric(trimdata$Global_active_power)/1000

png('plot4.png')
par(mfrow = c(2,2))
with(trimdata, {
  plot(datetime, x, ylab = "Global Active Power", xlab = " ", type = "l")
  plot(datetime, Voltage, ylab = "Voltage", type = "l")
  plot(trimdata$datetime, trimdata$Sub_metering_1, type = "l", ylab = "Energy Submetering", xlab = " ")
  points(trimdata$datetime, trimdata$Sub_metering_2, type = "l", col = "blue")
  points(trimdata$datetime, trimdata$Sub_metering_3, type = "l", col = "red")
  legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1, col = c("black","blue", "red"))
  plot(datetime, Global_reactive_power, type = "l")
})
dev.off()
