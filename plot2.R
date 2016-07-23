
#######################################################
# Exploratory Data Analysis - Proeject 2 - Question #1#
#######################################################

# Loading provided datasets - loading from my pre-set working directory by using the "setwd" commend
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Sampling
NEI_sampling <- NEI[sample(nrow(NEI), size=5000, replace=F), ]

# Subset data and append two years in one data frame
MD <- subset(NEI, fips=='24510')


# Generate the graph in the same directory as the source code
png(filename='plot2.png')

barplot(tapply(X=MD$Emissions, INDEX=MD$year, FUN=sum), 
        main='Total Emissions in Baltimore City, MD', 
        xlab='Years', ylab=expression('PM'[2.5]))

dev.off()
