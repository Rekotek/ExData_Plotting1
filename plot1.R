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

#filtered <- filtered %>%
#  mutate(DateAndTime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")))

# I'm using MacOS
quartz()

# Building histogramm
hist(filtered$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")

dev.copy(png, file = 'plot1.png', width=480, height=480)
dev.off
