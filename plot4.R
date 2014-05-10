
# read data.frame from a ';' seperated file
# define column classes
# NA symbol in this data is '?'
df <- read.table("household_power_consumption.txt", 
                 sep=";", header=TRUE, 
                 colClasses = c("character", "character", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric", "numeric"), 
                 na.strings = "?")

# get the date strings into the R Date class
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
# extract only the data for the two days required
df2 <- df[df$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

# create a vector in the POSIXlt class that combines date and time
# so that it can be used as the time axis on the plot
# first paste merge the date and the time field as string
datetime <- cbind(as.character(df2$Date), df2$Time)
datetime2 <- apply(datetime, 1, paste, collapse=" ")
# now convert to the POSIX class
x <- strptime(datetime2, "%Y-%m-%d %H:%M:%S")

# set the png device for the plot
png('plot4.png', width = 480, height = 480, units = 'px')
# prepare for four plots in two rows and two columns
par(mfrow = c(2,2))
# plot 1
plot(x, df2$Global_active_power, type='l', main='', xlab='', ylab='Global Active Power')
# plot 2
plot(x, df2$Voltage, type='l', main='', xlab='datetime', ylab='Voltage')
# plot 3
plot(x, df2$Sub_metering_1, type='l', col='black', main='', xlab='', ylab='Energy sub metering')
lines(x,  df2$Sub_metering_2, type='l', col='red')
lines(x,  df2$Sub_metering_3, type='l', col='blue')

# bty = n for: no line around the legend box
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty ='n',
       lty = c(1,1,1),
       col=c("black","red", "blue"))

# plot 4
plot(x, df2$Global_reactive_power, type='l', main='', xlab='datetime', ylab='Global_reactive_power')

# don't forget to close the device
dev.off()
