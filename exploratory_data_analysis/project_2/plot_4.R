setwd("C:/Users/aidan/data_science/datasciencecoursera/exploratory_data_analysis/project_2")

emissions <- readRDS("summarySCC_PM25.rds")
classification <- readRDS("Source_Classification_Code.rds")

sub <- classification[grepl("[Cc]oal", classification$Short.Name)==TRUE, 1]
data <- emissions[emissions$SCC %in% sub, ]

png(filename="plot_4.png", width=480, height=480)
par(mfrow=c(1,1))
x <- unique(data$year)
y <- NULL
for (i in x) {
  y <- c(y, sum(data$Emissions[data$year==i]))
}

plot(x, y, type="p", pch=16, cex=2, col="blue", main="Total Emissions from coal combustion related sources", xlab="Year", ylab="Total Emissions")
abline(lm(y~x))
dev.off()
