##reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##loading dplyr package
library(dplyr)

##filtering rows based on years
d1 <- NEI %>% filter(year == 1999)
d4 <- NEI %>% filter(year == 2008)

##converting integer column of years into factors
NEI <- transform(NEI, year = factor(year))
##setting output info
png(file="plot1.png", height = 480, width = 480)
##making a box plot
boxplot(log10(Emissions)~year, NEI,xlab="year", ylab="Emissions")
##adding appropriate lines for medians
abline(h=median(log10(d1$Emissions)), col="red", lw = 0.5)
abline(h=median(log10(d4$Emissions)), col="green", lw=1)
##adding index
legend("bottomleft", col=c("red","green"), lwd=c(0.5,1), c("Median in 1999", "Median in 2008"))
title(main = expression('PM'[2.5]*'Emissions in US from 1999-2008'))
dev.off()
