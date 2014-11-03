#setwd("C:/Users/aidan/data_science/datasciencecoursera/exploratory_data_analysis/project_2")
library(ggplot2)
emissions <- readRDS("summarySCC_PM25.rds")
classification <- readRDS("Source_Classification_Code.rds")

emissions <- emissions[emissions$fips=="24510",]
emissions$year <- as.factor(emissions$year)
  
png(filename="plot_3.png", width=480, height=480)
plot_3 <- ggplot(emissions, aes(year, Emissions))
plot_3 + geom_point() + geom_smooth(method="lm", formula=y~x, aes(group=1)) + 
  facet_grid(. ~ type) + coord_cartesian(ylim=c(0, 150))
dev.off()
