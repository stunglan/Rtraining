# view / analyse recent plays
library(plyr)
library(ggplot2)

data <- read.table("data/recentplays.csv",col.names=c("name","album","artist","uts","year","month","day","hour"),stringsAsFactors = FALSE,na.strings = "NA")

data <- subset(data,grepl("[01-9]{10,10}",uts)) # remove invalid uts

data <- transform(data,
                  time = as.POSIXlt(as.numeric(uts),origin = "1970-01-01")
)

data <- transform(data,
                  hourOnly = format(time, format = "%H")
)

y <-count(data,"artist")
y <- y[with(y,order(-freq)),]
qplot(freq,artist,data=y)

ggplot(data=head(y,100), aes(x=freq, y=reorder(artist,freq))) + geom_point(size=3) + theme_bw() +
  theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey60",linetype="dashed"))






# plot on what hour of the day i play music
data.timeofday <- count(data,"hourOnly")
ggplot(data.timeofday,aes(x=hourOnly,y=freq)) + geom_bar(stat="identity")
#-------

#what music do i play at 5 aclock
data.atfive <- subset(data,hourOnly=="05")



data.perday <- ddply(bnames, c("day"), transform, 
                     rank = rank(-percent, ties.method = "first"))

View(songs)

Sys.time()
help.search("date time")
(now <- as.POSIXlt(Sys.time()))
t <- as.numeric("1409209057")
(d <- as.POSIXlt(t,origin = "1970-01-01"))
d$year
