library(dplyr)

# Load full dataset
data <- read.csv('./data/household_power_consumption.txt',
                 na.strings = '?',
                 sep = ";",
                 colClasses = c("character", "character", rep("numeric", 7)))

# Filter and converting date
filtered <- data %>% 
  filter( (Date == "1/2/2007") | (Date == "2/2/2007") )

rm(data)

filtered <- filtered %>%
  mutate(DateAndTime = as.POSIXct(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S")))

# I'm using MacOS
quartz()

# Init a 2x2 table
par(mfrow=c(2,2))

# Build plots
with(filtered, {
  plot(Global_active_power ~ DateAndTime,
      xlab = "",
      ylab = "Global Active Power",
      type = "l")
  plot(Voltage ~ DateAndTime,
      xlab = "datetime",
      ylab = "Voltage",
      type = "l")
  plot(Sub_metering_1 ~ DateAndTime,
      type = "l",
      xlab = "",
      ylab = "Energy sub metering",
      col = "black")
    lines(Sub_metering_2 ~ DateAndTime, type = "l", col = "red")
    lines(Sub_metering_3 ~ DateAndTime, type = "l", col = "blue")
    legend("topright",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 2, bty = "n")
  plot(Global_reactive_power ~ DateAndTime,
       xlab="datetime", 
       ylab="Global_reactive_power",
       type="l")
})

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()