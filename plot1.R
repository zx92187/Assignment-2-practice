
#######################################################
# Exploratory Data Analysis - Proeject 2 - Question #1#
#######################################################

# Loading provided datasets - loading from my pre-set working directory by using the "setwd" commend. 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Sampling
NEI_sampling <- NEI[sample(nrow(NEI), size=2000, replace=F), ]

# Aggregate
Emissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
Emissions$PM <- round(Emissions[,2]/1000,2)

# Graphing
png(filename='plot1.png')

barplot(Emissions$PM, names.arg=Emissions$Group.1, 
        main=expression('Total Emissions of PM'[2.5]),
        xlab='Years', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.off()
