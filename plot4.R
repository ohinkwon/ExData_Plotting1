## Download & unzip the data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/elec.zip")
unzip(zipfile = "./data/elec.zip", exdir="./data")

## Loading dataset
data <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(subset$Date), subset$Time)
subset$DateTime <- as.POSIXct(datetime)

## Plot 4 and saving PNG
par(mfrow=c(2,2))
with(subset, {
  plot(Global_active_power ~ DateTime, type = "l", ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ DateTime, type="l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering", xlab="")
  lines(Sub_metering_2 ~ DateTime, col = "red")
  lines(Sub_metering_3 ~ DateTime, col = "blue")
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, bty="n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.7, y.intersp = 0.8, x.intersp = 0.8)
  plot(Global_reactive_power ~ DateTime, type = "l", ylab="Global_rective_power",xlab = "datetime")
})
dev.copy(png, file="./data/plot4.png", height=480, width=480)
dev.off()
