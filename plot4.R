# library calls
library(dplyr)
library(magrittr)

# read in the dataset
dat <- read.csv2("household_power_consumption.txt", stringsAsFactors = FALSE, na.strings = "?")


# convert Time to Date/Time class
# convert Date to date class
# filter to the right days
# convert everything else to numeric
dat <- dat %>% 
   mutate(
      newDate = as.POSIXct(strptime(paste(Date,Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")),
      Date = as.Date(Date, format = "%d/%m/%Y")) %>% 
   filter(Date >= "2007-02-01",
          Date <= "2007-02-02") %>% 
   mutate_at(vars(Global_active_power,
                  Global_reactive_power,
                  Voltage,
                  Global_intensity,
                  Sub_metering_1,
                  Sub_metering_2,
                  Sub_metering_3),
             as.numeric)

# initialize the png graphics device
png("ExData_Plotting1/plot4.png", width=480, height=480)

# set the grid
par(mfrow = c(2,2))

# Plot 1
plot(dat$newDate, dat$Global_active_power,
     type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(dat$newDate,dat$Voltage,
     type="l", xlab="datetime",
     ylab="Voltage")

# Plot 3
plot(dat$newDate, dat$Sub_metering_1, 
     type="l", xlab="",
     ylab="Energy sub metering")
lines(dat$newDate, dat$Sub_metering_2,
      col="red")
lines(dat$newDate, dat$Sub_metering_3,
      col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex= .85
       ) 

# Plot 4
plot(dat$newDate, dat$Global_reactive_power,
     type="l", xlab="datetime", ylab="Global_reactive_power")

# close the device
dev.off()
