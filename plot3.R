# read data.frame from a ';' seperated file
# define column classes
# NA symbol in this data is '?'
df <- read.table("household_power_consumption.txt", sep=";", header=TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")
# get the date strings into the R Date class
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
# extract only the data for the two days required
df2 <- df[df$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

datetime <- cbind(as.character(df2$Date), df2$Time)
datetime2 <- apply(datetime, 1, paste, collapse=" ")
x <- strptime(datetime2, "%Y-%m-%d %H:%M:%S")

# set the png device for the plot
png('plot3.png', width = 480, height = 480, units = 'px')
# plot the line plot (type='l')
plot(x, df2$Sub_metering_1, type='l', col='black', main='', xlab='', ylab='Energy sub metering')
lines(x,  df2$Sub_metering_2, type='l', col='red')
lines(x,  df2$Sub_metering_3, type='l', col='blue')

legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), 
       col=c("black","red", "blue"))

# don't forget to close the device
dev.off()

