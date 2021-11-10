library(dplyr)
library(data.table)
library(lubridate)

path <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Create directory if it doesn't already exist
if (!dir.exists("./data")){
  
  dir.create("./data")
  
}

download.file(path, "./data/data.zip")
unzip("./data/data.zip", exdir = "./data")


data <- fread("./data/household_power_consumption.txt", sep = ";", na.strings = "?")

subset_data <- data %>% 
    as_tibble() %>% 
    mutate(Date = as.Date(Date, "%d/%m/%Y"), ) %>%  
    filter(Date >= '2007-02-01' & Date <= '2007-02-02' ) %>% 
    mutate(date_with_time = strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S"))

png(filename = "plot4.png", width = 480, height = 480)


par(mfrow = c(2, 2)) # 2 rows 2 columns
#Plot for Global active power
with(subset_data, plot(date_with_time, Global_active_power, type="l",  xlab = "", ylab = "Global Active Power"))

#Plot for voltage
with(subset_data, plot(date_with_time, Voltage, type="l",  xlab = "datetime", ylab = "Voltage"))

#Plot for Sub metering
with(subset_data, plot(date_with_time, Sub_metering_1, type="n",  xlab = "", ylab = "Energy sub metering"))

with(subset_data, points(date_with_time, Sub_metering_1, type="l",  xlab = "", col = "black"))

with(subset_data, points(date_with_time, Sub_metering_2, type="l",  xlab = "", col = "red"))

with(subset_data, points(date_with_time, Sub_metering_3, type="l",  xlab = "", col = "blue"))

legend("topright", col=c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Plot for Global reactive power
with(subset_data, plot(date_with_time, Global_reactive_power, type="l",  xlab = "datetime", ylab = "Global_reactive_power"))


dev.off()


