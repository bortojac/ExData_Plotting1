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

# plot2

plot(dat$newDate, 
     dat$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
     )

# copy the file to a png file
dev.copy(png, file="ExData_Plotting1/plot2.png", height=480, width=480)
dev.off()

