# view / analyse recent plays
library(plyr)
library(ggplot2)
setwd("~/GitHub/Rtraining")

source("getPlays.R")

data <- getPlays()
#most popular artists

z <- ddply(data, c("artist"), summarise, freq = length(artist) )

z <- z[order(z$freq),]
z <- tail(z,n = 20)

p <- ggplot(data=z, aes(x=freq, y=reorder(artist,freq),origin=0)) 
p + geom_point(size=3) + theme_bw() +
  theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey60",linetype="dashed"))

#end most popular artist 
# 100 mest poppis
y <-count(data,c("artist"))
order(y$freq,decreasing=T)

ggplot(data=head( y[order(y$freq,decreasing=T),],100), aes(x=freq, y=reorder(artist,freq))) + geom_point(size=3) + theme_bw() +
  theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey60",linetype="dashed"))

#end 100 mest poppis

# når var lw poppis
y1 = subset(data,artist== "Lars Winnerbäck")
y1 = subset(data,artist== "Sigrid Moldestad")
ggplot(y1,aes(x=month,fill=year)) + geom_histogram()

ggplot(y1,aes(x=y1$time)) + geom_density() + geom_line(stat="density",adjust=0.5,colour="red")

# end når var lw poppis



# bruke ddply for å telle lengden på vektoren
z <- ddply(data, c("artist","year","month"), summarise, freq = length(artist) )
z <- subset(z, artist == "Lars Winnerbäck")

z$year <- factor(z$year)
z <- transform(z,
                  date = as.Date(paste(month,"-1",sep=""))
)

ggplot(z,aes(x=z$date,y=z$freq)) + geom_line()

# end bruke ddply for å telle lengden på vektoren

# test ulike plott

y <-count(data,c("artist"))
y <- subset(y,freq > 1)
lt500 <- subset(y, freq <  500)


ggplot(lt500,aes(x=lt500$freq,y=..density..)) + geom_histogram(binwidth=50,origin=30) + geom_density()

ggplot(lt500,aes(x=lt500$freq)) + geom_density()

ggplot(lt500,aes(x=lt500$freq)) + geom_line(stat="density")

# end test ulike plott

# hvilken måned hører jeg mes på musikk
y <-count(data,c("artist","year","monthOnly"))

y$year <- factor(y$year)
ggplot(y,aes(x=y$monthOnly,y=y$freq,colour=y$year)) + geom_bar(stat="identity")


ggplot(y,aes(x=y$month,colour=y$year)) + geom_bar(stat="density")
ggplot(y,aes(x=y$month,fill=y$year)) + geom_histogram()

# end hvilken måned hører jeg mes på musikk

# mest pop i et år
y <-count(data,c("artist","year"))
y <- y[with(y,order(year,-freq)),]
y$year <- factor(y$year)

y.df <- head(subset(y,year=="2013"),100)


tmp <- by(y,y$year,function(x) head(x,10))


ggplot(data=y.df, aes(x=freq, y=reorder(artist,freq))) + geom_point(size=3,aes(colour=year)) + theme_bw() +
  theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey60",linetype="dashed"))

#end mest pop i et år


yearorder <- y$artist[order(y$year,-y$freq)]
y$artist <- factor(y$artist,levels=yearorder)
y$year <- factor(y$year)


# plot on what hour of the day i play music
data.timeofday <- count(data,"hourOnly")
ggplot(data.timeofday,aes(x=hourOnly,y=freq)) + geom_bar(stat="identity")
#end plot on what hour of the day i play music
#-------

#what music do i play at 5 aclock
data.atfive <- subset(data,hourOnly=="22")
y <- count(data.atfive,c("artist"))
y <- head(y[order(-y$freq),],10) 


ggplot(data=y, aes(x=freq, y=reorder(artist,freq))) + geom_point(size=3) + theme_bw() +
  theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour="grey60",linetype="dashed"))


  



