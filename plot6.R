##reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##loading dplyr package
library(dplyr)
##loading ggplot2 package
library(ggplot2)
##setting output info
png(file="plot6.png", height = 480, width = 480)
##grabbbing baltimore and LA dataset
balti_los <- NEI %>% filter(fips=="24510" | fips=="06037")
##grabbing SCC of type onroad(this includes all onroad vehicles)
scc_list <- SCC %>% filter(Data.Category == "Onroad")
##selecting only roads which are in scc_list
req_dt <- balti_los %>% filter(SCC %in% scc_list[,1])
##aggregate to find means of all sources in a year by cities
req_dt <- aggregate(Emissions~year+fips, req_dt, mean)
##plotting
ggplot(req_dt, aes(year,Emissions, colour=fips))+
        geom_point()+
        geom_line()+
        ggtitle(expression("Comaprision of motor vehicle PM"[2.5]*"Emission between Baltimore city and Los Angeles from 1999-2008"))+
        scale_colour_discrete(name = "City", labels = c("Los Angeles", "Baltimore"))
dev.off()