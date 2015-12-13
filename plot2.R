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

png('plot2.png')
plot(trimdata$datetime,x, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
