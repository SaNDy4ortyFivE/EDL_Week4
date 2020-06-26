##reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##loading dplyr package
library(dplyr)
##loading ggplot2 package
library(ggplot2)
##setting output info
png(file="plot4.png", height = 480, width = 480)
##grabbing SCC which have 'coal' as substring in them
scc_list <- SCC[grep("coal", SCC[,4], ignore.case = TRUE), c(1)]
##filtering out rows which are present in scc_list
req_db <- NEI %>% filter( SCC %in% scc_list)
##calculating means for all types of sources in a particular year
points <- aggregate(Emissions~year, req_db, mean)
##plotting
ggplot(points, aes(year,Emissions))+
        geom_point()+
        geom_line()+
        ggtitle(expression("PM"[2.5]*"Emissions related to coal(1999-2008)"))
dev.off()