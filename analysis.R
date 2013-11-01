setwd("~/projects/wal/gamebreaker-r")
source("GameBreakerEditFileParser.R")

library(ggplot2)
gb_data <- parseEditFile("teams/leinsteru18/L18vCHC.xml")

summary(gb_data)

gb_data$startTimes <- round(gb_data$startTimes/60, 0)
gb_data$endTimes <- round(gb_data$endTimes/60, 0)

levels(gb_data$codes)


turnovers <- gb_data[gb_data$codes %in% c("Turnover","Oppo Turnover"), c("startTimes", "codes")]
tw3_entries <- gb_data[gb_data$codes %in% c("23 Entry","Oppo 23 entry"), c("startTimes", "codes")]
chances <- gb_data[gb_data$codes %in% c("Chance"), c("startTimes", "codes")]
circle_entries <- gb_data[gb_data$codes %in%  c("Circle entry", "Oppo Circle entry"), c("startTimes", "codes")]
steals <- gb_data[gb_data$codes %in% c("Steal"), c("startTimes", "codes")]
penalty_corners <- gb_data[gb_data$codes %in% c("PC concession", "PC win") , c("startTimes", "codes")]

attack_codes <- c("23 Entry", "Circle entry", "Chance", "PCA", "Goal")
attack <- gb_data[gb_data$codes %in% attack_codes , c("startTimes", "codes")]
attack$codes <- factor(attack$codes, levels=attack_codes)

defence_codes <- c("Oppo 23 entry", "Oppo Circle entry", "PCD", "Goal conceded")
defence <- gb_data[gb_data$codes %in% defence_codes, c("startTimes", "codes")]
defence$codes <- factor(defence$codes, levels=defence_codes)

library(gridExtra)
p0 <- ggplot(gb_data, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1) + ggtitle("Match Summary") + xlab("Match Minute") + facet_grid(codes ~.) + theme(strip.text.y = element_text(size=6, angle=360), legend.position="none", axis.text.y = element_blank(), axis.ticks = element_blank()) + scale_x_continuous(breaks=seq(0,90,5))
p1 <- ggplot(turnovers, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("Turnovers") + xlab("Match Minute")
p2 <- ggplot(tw3_entries, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("23 Entries") + xlab("Match Minute")
p3 <- ggplot(chances, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("Chances") + xlab("Match Minute")
p4 <- ggplot(circle_entries, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("Circle Entries") + xlab("Match Minute")
p5 <- ggplot(steals, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("Steals") + xlab("Match Minute")
p6 <- ggplot(penalty_corners, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("Penalty Corners") + xlab("Match Minute")

p7 <- ggplot(attack, aes(x=startTimes, fill=codes)) + geom_histogram(binwidth=1) + ggtitle("Attack") + xlab("Match Minute")
p8 <- ggplot(defence, aes(x=startTimes, fill=codes)) + geom_histogram(binwidth=1) + ggtitle("Defence") + xlab("Match Minute")

pdf("LeiCHC.pdf")
grid.arrange(p0, main="Match Summary")
grid.arrange(ncol=2, p1, p2, p3, p4, p5, p6,  main ="Leinster U18s V's CHC - Overview")
grid.arrange(ncol=1, p7, p8, main="Attack/Defence")
dev.off()



