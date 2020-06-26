##reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##loading dplyr package
library(dplyr)
##loading ggplot2 package
library(ggplot2)
##setting output info
png(file="plot3.png", height = 480, width = 480)
##getting rows in baltimore
baltimore_dt <- NEI %>% filter(fips == "24510")
##coverting year(integer) into year(factors)
baltimore_dt <- transform(baltimore_dt, year = factor(year))
##aggregating i.e calculating means of emissions of a particular type in year
points <- aggregate(Emissions~year+type, baltimore_dt, mean)
##plotting it
ggplot(points, aes(year, Emissions, group=type, colour=type))+
        geom_point()+
        geom_line()+
        labs(title = expression('PM'[2.5]*'Emissions in Baltimore based on different types of Sources'))

dev.off()
