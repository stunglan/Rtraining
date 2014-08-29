# read data into a local data file
library(rjson)
library(RCurl)
library(plyr)

source("localconfig.R")
filename <- "data/recentplays.csv"

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
toHour <- function(x) {
  y <- toDate(x)
  format(y, format = "%Y-%m-%d %H")
}


getData <- function() {
#  unlink(filename) # comment after first read
  page.nr <- 1 # start page
  page.nrend <- 1000000 # end page plays*100 581-589
  after_utc <- "from=1409309253" # get only artists after this timestamp
  
  uri.raw <- "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&%s&%s&limit=100&page=%s&format=json"
  repeat{
    data <- NULL
    uri.cooked <- sprintf(uri.raw,after_utc,mykey,page.nr)
    json <- getURL(uri.cooked)
    page <- fromJSON(json)
    
    if (is.numeric(page[[1]]) | page.nr > page.nrend) {
      if (is.numeric(page[[1]]))
        print(page)
      break
    }
    else
    {
      page.songs <- lapply(page[[1]]$track, function(x) c(x$name,x$album['#text'],x$artist['#text'],x$date$uts))
      page.songs <- do.call(rbind, page.songs)
      page.songs <- data.frame(page.songs)
      
      data <- rbind(data,page.songs)
      
      names(data) <- c("name","album","artist","uts")
      data[1] <- unlist(data[1])
      data[2] <- unlist(data[2])
      data[3] <- unlist(data[3])
      data[4] <- unlist(data[4])
      data <- transform(data,
                        year = toYear(uts),
                        month = toMonth(uts),
                        day = toDay(uts),
                        hour = toHour(uts)
      )
      
      write.table(data,file = filename ,append=TRUE,row.names=FALSE,col.names = FALSE)
      
      if (length(page[[1]]) < 100) # last page
        page.nr <- page.nrend + 1
      else 
        page.nr <- page.nr +1
      Sys.sleep(0.3) # limit on how many reads
    }
    

    
  } # repeat
  
  page.nr



}

data <- getData()








