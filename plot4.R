##reading data
data <- read.table("extracted/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
##converting to appropriate Date format
data$Date <- as.Date(data$Date, "%d/%m/%Y")
##getting only rows between 1st feb and 2nd feb 2007
req_data <- data[which(data$Date>=as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02")),]

png(file="plot4.png", height = 480, width = 480)

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
##changing parameters for accomodating 4 graphs
par(mfrow=c(2,2))
##plotting
with(req_data, {
        ##plot1
        plot(Global_active_power~dt1, type="l" ,ylab="Global Active Power(kilowatts)", xlab="")
        ##plot2
        plot(Voltage~dt1, type="l", ylab="Voltage (volt)", xlab="")
        ##plot3 submeter1
        plot(Sub_metering_1~dt1, type="l", ylab="Global Active Power(kilowatts)", xlab="")
        ##plot3 submeter2
        lines(Sub_metering_2~dt1,col='Red')
        ##plot3 submeter 3
        lines(Sub_metering_3~dt1,col='Blue')
        ##Adding legend
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        ##plot4
        plot(Global_reactive_power~dt1, type="l", ylab="Global Rective Power(kilowatts)",xlab="")
})
##closing deivce
dev.off()