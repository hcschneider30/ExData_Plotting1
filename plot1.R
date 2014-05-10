
# read data.frame from a ';' seperated file
# define column classes
# NA symbol in this data file is '?'
df <- read.table("household_power_consumption.txt", 
                 sep=";", 
                 header=TRUE, 
                 colClasses = c("character", "character", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric", "numeric"), 
                 na.strings = "?")

# get the date strings into the R Date class
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
# extract only the data for the two days required
df2 <- df[df$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

# set the png device for the plot
png('plot1.png', width = 480, height = 480, units = 'px')
# plot the histogram
hist(df2$Global_active_power, col='red', breaks=12, main='Global Active Power', 
     xlab='Global Active Power (kilowatts)', ylab='Frequency')
# don't forget to close the device
dev.off()
