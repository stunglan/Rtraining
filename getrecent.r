
library(rjson)
library(RCurl)
library(plyr)
library(ggplot2)

source("localconfig.R")


toDate <- function(x) {
  date <- as.numeric(x)
  as.POSIXlt(date,origin = "1970-01-01")
}

toYear <- function(x) {
  y <- toDate(x)
  y$year+1900
}
toMonth <- function(x) {
  y <- toDate(x)
  format(y, format = "%Y-%m")
}
toDay <- function(x) {
  y <- toDate(x)
  format(y, format = "%Y-%m-%d")
}
toTime <- function(x) {
  y <- toDate(x)
  format(y, format = "%H-%M-%S")
}


getData <- function() {
  data <- NULL
  uri.raw <- "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&u%s&limit=100&page=%s&format=json"
  page.nr = 1
  repeat{
    uri.cooked <- sprintf(uri.raw,mykey,page.nr)
    json <- getURL(uri.cooked)
    page <- fromJSON(json)
    
    if (is.numeric(page[[1]]) | page.nr > 10) {
      if (is.numeric(page[[1]]))
        page[[1]]
      break
    }
    else
    {
      page.songs <- lapply(page[[1]]$track, function(x) c(x$name,x$album['#text'],x$artist['#text'],x$date$uts))
      page.songs <- do.call(rbind, page.songs)
      page.songs <- data.frame(page.songs)
      
      data <- rbind(data,page.songs)
      page.nr <- page.nr +1
    }
    
  } # repeat
  names(data) <- c("name","album","artist","uts")
  data
}

data <- getData()


if (is.null(data)) {
  "No data"
  quit()
}






data[1] <- unlist(data[1])
data[2] <- unlist(data[2])
data[3] <- unlist(data[3])
data[4] <- unlist(data[4])
data <- transform(data,
                  year = toYear(uts),
                  month = toMonth(uts),
                  day = toDay(uts)
)

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
