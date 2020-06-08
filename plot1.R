##reading data
data <- read.table("extracted/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
##converting to appropriate Date format
data$Date <- as.Date(data$Date, "%d/%m/%Y")
##getting only rows between 1st feb and 2nd feb 2007
req_data <- data[which(data$Date>=as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02")),]

png(file="plot1.png", height = 480, width = 480)
##plotting
hist(req_data$Global_active_power, xlim = c(0,6), xlab = "Global Active Power(kilowatts)", col = "red", main = "Global Active Power")
##closing deivce
dev.off()