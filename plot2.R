##reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##loading dplyr package
library(dplyr)
##setting output info
png(file="plot2.png", height = 480, width = 480)
##getting rows in baltimore
baltimore_dt <- NEI %>% filter(fips == "24510")
##coverting year(integer) into year(factors)
baltimore_dt <- transform(baltimore_dt, year = factor(year))
##plotting
boxplot(log10(Emissions)~year, baltimore_dt, xlab="year", ylab="Emissions")
title(main = expression('PM'[2.5]*'Emissions in Baltimore From 1999-2008'))
dev.off()