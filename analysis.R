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

attack <- gb_data[gb_data$codes %in% c("23 Entry", "Circle entry", "Chance", "PCA", "Goal") , c("startTimes", "codes")]
defence <- gb_data[gb_data$codes %in% c("Oppo 23 Entry", "Oppo Circle entry", "PCD", "Goal conceded") , c("startTimes", "codes")]

library(gridExtra)
p1 <- ggplot(turnovers, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("Turnovers") + xlab("Match Minute")
p2 <- ggplot(tw3_entries, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("23 Entries") + xlab("Match Minute")
p3 <- ggplot(chances, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("Chances") + xlab("Match Minute")
p4 <- ggplot(circle_entries, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("Circle Entries") + xlab("Match Minute")
p5 <- ggplot(steals, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("Steals") + xlab("Match Minute")
p6 <- ggplot(penalty_corners, aes(x=startTimes, color=codes)) + geom_histogram(binwidth=1, alpha=.2) + ggtitle("Penalty Corners") + xlab("Match Minute")

p7 <- ggplot(attack, aes(x=startTimes, fill=codes)) + geom_histogram(binwidth=1) + ggtitle("Attack") + xlab("Match Minute")
p8 <- ggplot(defence, aes(x=startTimes, fill=codes)) + geom_histogram(binwidth=1) + ggtitle("Defence") + xlab("Match Minute")

pdf("LeiCHC.pdf")
grid.arrange(ncol=2, p1, p2, p3, p4, p5, p6,  main ="Leinster U18s V's CHC - Overview")
dev.off()

pdf("LeiCHCAttackDefence.pdf")
grid.arrange(ncol=1, p7, p8, main ="Leinster U18s V's CHC - AttackDefence")
dev.off()


