##reading data
data <- read.table("extracted/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
##converting to appropriate Date format
data$Date <- as.Date(data$Date, "%d/%m/%Y")
##getting only rows between 1st feb and 2nd feb 2007
req_data <- data[which(data$Date>=as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02")),]
##getting Date column
d <- req_data$Date
##getting Time column
t <- req_data$Time
##merging date and time column for converting into posix format
dt <- paste(d,t)
##converting into posix format
dt1 <- as.POSIXct(dt)
##adding new column 'dt1'
req_data <- cbind(req_data,dt1)

png(file="plot3.png", height = 480, width = 480)
##plotting
with(req_data, {
        plot(Sub_metering_1~dt1, type="l", ylab="Global Active Power(kilowatts)", xlab="")
        lines(Sub_metering_2~dt1,col='Red')
        lines(Sub_metering_3~dt1,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##closing deivce
dev.off()