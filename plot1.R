#library(readr)
library(dplyr)
library(data.table)
#library(sqldf)

path <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Create directory if it doesn't already exist
if (!dir.exists("./data")){
  
  dir.create("./data")
  
}

download.file(path, "./data/data.zip")
unzip("./data/data.zip", exdir = "./data")


#df <- read.csv.sql("./data/household_power_consumption.txt", "select  * from file where Date BETWEEN '01/02/2007' AND '02/02/2007'", sep = ";")


data <- fread("./data/household_power_consumption.txt", sep = ";", na.strings = "?")

subset_data <- data %>% 
    as_tibble() %>% 
    #mutate(Date = as.Date(Date, "%d/%m/%Y"), ) %>%  Not sure why as.Date is needed if using strptime
    mutate(Date_Time = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")) %>% 
    filter(format(Date_Time, "%Y-%m-%d") >= '2007-02-01' & format(Date_Time, "%Y-%m-%d") <= '2007-02-02' )

png(filename = "plot1.png", width = 480, height = 480)

hist(subset_data$Global_active_power, col = "red", main = "", xlab = "Global Active Power (kilowatts)")    

dev.off()


