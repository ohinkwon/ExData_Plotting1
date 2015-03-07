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

## Plot 3 and saving PNG
with(subset, {
  plot(Sub_metering_1 ~ DateTime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2 ~ DateTime, col="red")
  lines(Sub_metering_3 ~ DateTime, col="blue")
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8, y.intersp = 0.8)
dev.copy(png, file="./data/plot3.png", height=480, width=480)
dev.off()
