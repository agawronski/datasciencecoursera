#setwd("C:/Users/aidan/data_science/datasciencecoursera/exploratory_data_analysis/project_2")

emissions <- readRDS("summarySCC_PM25.rds")
classification <- readRDS("Source_Classification_Code.rds")

#Questions 2 ... use base plotting
# x axis plot years 1999, 2002, 2005, 2008
# y axis plot total emissions from PM2.5 for 
# Baltimore City, Maryland (fips == "24510")
x <- unique(emissions$year)
y <- NULL
for (i in x) {
  y <- c(y, sum(emissions$Emissions[emissions$year==i & emissions$fips=="24510"]))
}
png(filename="plot_2.png", width=480, height=480)
plot(x, y, type="p", pch=16, cex=2, col="blue", main="total emissions from PM2.5 by year in Baltimore City, Maryland", xlab="Year", ylab="Total Emissions")
abline(lm(y~x))
dev.off()
