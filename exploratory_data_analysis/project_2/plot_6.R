setwd("C:/Users/aidan/data_science/datasciencecoursera/exploratory_data_analysis/project_2")

emissions <- readRDS("summarySCC_PM25.rds")
classification <- readRDS("Source_Classification_Code.rds")

sub <- classification[grepl("[Mm]otor", classification$Short.Name)==TRUE, 1]

balt <- emissions[emissions$fips=="24510",]
data <- balt[balt$SCC %in% sub, ]

la <- emissions[emissions$fips=="06037",]
data2 <- la[la$SCC %in% sub, ]

png(filename="plot_6.png", width=480, height=480)
par(mfrow=c(2,1))
x <- unique(data$year)
y <- NULL
for (i in x) {
  y <- c(y, sum(data$Emissions[data$year==i]))
}

plot(x, y, type="p", pch=16, cex=2, col="blue", main="Total Emissions from motor vehicles in Baltimore City", xlab="Year", ylab="Total Emissions")
abline(lm(y~x))

x2 <- unique(data2$year)
y2 <- NULL
for (i in x2) {
  y2 <- c(y2, sum(data2$Emissions[data2$year==i]))
}

plot(x2, y2, type="p", pch=16, cex=2, col="blue", main="Total Emissions from motor vehicles in Los Angeles County", xlab="Year", ylab="Total Emissions")
abline(lm(y2~x2))

dev.off()

