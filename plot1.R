library(data.table)

# Download and unzip file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "household_power_consumption.zip", mode = "wb")
unzip("household_power_consumption.zip", exdir = "household_power_consumption")

# Read to txt to data frame filtering for 1/2/2007 and 2/2/2007
data <- fread(cmd = paste(
        "grep '^[12]/2/2007'",
        "household_power_consumption/household_power_consumption.txt"
), sep = ";")

# Assign col names
column_names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                  "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                  "Sub_metering_3")
colnames(data) <- column_names

# Convert Date time and combine with Time for POS type
data$Date <- as.Date(data$Date, "%d/%m/%Y")  
data$Time <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Open png device and set 480x480
png("plot1.png", width = 480, height = 480)

# Create histogram based on Global Active Power
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Turn off png device
dev.off()