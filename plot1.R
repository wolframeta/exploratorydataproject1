dataset <- read.csv("./household_power_consumption.txt", sep = ";")

dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")


install.packages("chron")
library(chron)
?chron
dataset$Time <- chron(times= dataset$Time)

trimdata <- subset(dataset, Date == "2007-02-01" | Date == "2007-02-02")

png('plot1.png')
hist(as.numeric(trimdata$Global_active_power)/1000, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()

