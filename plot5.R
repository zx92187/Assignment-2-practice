

#######################################################
# Exploratory Data Analysis - Proeject 2 - Question #5#
#######################################################

library(ggplot2)

# Loading provided datasets - loading from my pre-set working directory by using the "setwd" commend
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Getting Baltimore City, fips = 24510
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregating
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('Year', 'Emissions')

# Graphing
png('plot5.png')

ggplot(data=MD.df, aes(x=Year, y=Emissions)) + 
  geom_bar(stat = "identity") + guides(fill=F) + 
  ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City') + 
  ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

dev.off()
