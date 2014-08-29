# view / analyse recent plays

data <- read.table("data/recentplays.csv",col.names=c("name","album","artist","uts","year","month","day","hour")

count(data,"name")
count(data,c("name","day"))
data.perday <- count(data,"day")

qplot(day,freq,data = data.perday)

#-------

data.perday <- ddply(bnames, c("day"), transform, 
                     rank = rank(-percent, ties.method = "first"))

View(songs)

Sys.time()
help.search("date time")
(now <- as.POSIXlt(Sys.time()))
t <- as.numeric("1409209057")
(d <- as.POSIXlt(t,origin = "1970-01-01"))
d$year
