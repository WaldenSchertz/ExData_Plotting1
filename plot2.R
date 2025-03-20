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
png("plot2.png", width = 480, height = 480)

# Create line plot tracking Global Active Power over time
plot(data$Time, data$Global_active_power, type = "l", xaxt = "n",
     xlab = "", ylab = "Global Active Power (kilowatts)")

# Add custom x-axis ticks based on day
axis(1, at = as.numeric(c(min(data$Time), median(data$Time), max(data$Time))), 
     labels = c("Thu", "Fri", "Sat"))

# Turn off png device
dev.off()
