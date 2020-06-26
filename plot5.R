##reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##loading dplyr package
library(dplyr)
##loading ggplot2 package
library(ggplot2)
##setting output info
png(file="plot5.png", height = 480, width = 480)
##grabbbing baltimore dataset
baltimore_dt <- NEI %>% filter(fips=="24510")
##grabbing SCC of type onroad(this includes all onroad vehicles)
scc_list <- SCC %>% filter(Data.Category == "Onroad")
##selecting only roads which are in scc_list
req_dt <- baltimore_dt %>% filter(SCC %in% scc_list[,1])
##agrregate to find means of all rows in particular year
req_dt <- aggregate(Emissions~year, req_dt, mean)
##plotting
ggplot(req_dt, aes(year,Emissions))+
        geom_point()+
        geom_line()+
        ggtitle(expression("PM"[2.5]*"Emissions by motor vehicles in Baltimore city(1999-2008)"))
dev.off()