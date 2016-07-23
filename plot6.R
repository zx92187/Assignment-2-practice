#######################################################
# Exploratory Data Analysis - Proeject 2 - Question #6#
#######################################################

library(ggplot2)

# Loading provided datasets - loading from my pre-set working directory by using the "setwd" commend
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, fips = 24510
# Los Angeles County, fips = 06037
MD.OnRoad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA.OnRoad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregating
MD.DF <- aggregate(MD.OnRoad[, 'Emissions'], by=list(MD.OnRoad$year), sum)
colnames(MD.DF) <- c('Year', 'Emissions')
MD.DF$City <- paste(rep('MD', 4))

CA.DF <- aggregate(CA.OnRoad[, 'Emissions'], by=list(CA.OnRoad$year), sum)
colnames(CA.DF) <- c('Year', 'Emissions')
CA.DF$City <- paste(rep('CA', 4))

DF <- as.data.frame(rbind(MD.DF, CA.DF))



png('plot6.png')

ggplot(data=DF, aes(x=Year, y=Emissions)) + 
  geom_bar(stat = 'identity') + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County comparing to Baltimore City') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + 
  scale_y_continuous(breaks = seq(0, 5000, by = 1000)) + expand_limits(y=c(0,5000)) +
  theme(legend.position='none') + 
  facet_grid(. ~ City) + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

dev.off()



