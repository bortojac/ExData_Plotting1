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
# the legend was getting messed up from using dev.copy, so we initialize the png device here.
png("ExData_Plotting1/plot3.png", width=480, height=480)

# plot3
plot(dat$newDate,
     dat$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(dat$newDate, dat$Sub_metering_2,
      type = "l", col = "red")
lines(dat$newDate, dat$Sub_metering_3,
      type = "l", col = "blue")
legend("topright", 
       col = c("black", "red", "blue"),
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 2
       )
# close the graphics device
dev.off()