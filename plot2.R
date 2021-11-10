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

png(filename = "plot2.png", width = 480, height = 480)

with(subset_data, plot(date_with_time, Global_active_power, type="l",  xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()


