setwd("~/projects/wal/gamebreaker-r")
source("GameBreakerEditFileParser.R")

gb_data <- parseEditFile("~/Downloads/XML Edit list.xml")

gb_data$startTimes <- round(gb_data$startTimes/60, 0)
gb_data$endTimes <- round(gb_data$endTimes/60, 0)
levels(gb_data$codes)

corners <- gb_data[gb_data$codes %in% c("PCA","PCD"), ]

hist(gb_data[gb_data$codes == 'Oppo Circle entry', 'startTimes'])

library(ggplot2)
ggplot(corners, aes(startTimes, fill=codes)) + geom_histogram(alpha = 0.5)