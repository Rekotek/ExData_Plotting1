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

# Build a plot
with(filtered, plot(Sub_metering_1 ~ DateAndTime,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering",
  col = "black"))
# Add another 2 observations
with(filtered, lines(Sub_metering_2 ~ DateAndTime, type = "l", col = "red"))
with(filtered, lines(Sub_metering_3 ~ DateAndTime, type = "l", col = "blue"))
# and legend
legend("topright",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, lwd=2)

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()