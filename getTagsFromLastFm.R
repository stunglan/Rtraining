#get tags

library(rjson)
library(RCurl)
library(plyr)
setwd("~/GitHub/Rtraining")
source("localconfig.R")
filename <- "data/artistTags.csv"

source("getPlays.R")




data <- getPlays()
artists <- unique(data$artist)

artists <- data.frame(artists)

totalTags <- NULL

uri.raw <- "http://ws.audioscrobbler.com/2.0/?method=artist.gettoptags&artist=%s&%s&format=json"
for (a in artists$artists) {
  print(a)
  uri.cooked <- sprintf(uri.raw,curlEscape(a),mykey)
  json <- getURL(uri.cooked)
  page <- fromJSON(json)
  
  
  if (is.numeric(page[[1]])) {
    if (is.numeric(page[[1]]))
      print(page)
    break
  }
  else
    if (length(page[[1]]$tag) > 1 & is.null(page[[1]]$tag$name) ) {
      
      tags <- lapply(page[[1]]$tag, function(x) c(x$name,x$count))
      if (length(tags) > 0 ) {
        tags <- do.call(rbind, tags)
        tags <- data.frame(tags,stringsAsFactors = F)
        tags$artist <- a
        
        
        names(tags) <-c("tag","count","artist")
        
        tags <- subset(tags,as.numeric(count) > 50)
        tags <- tags[c("artist","tag","count")]
        
        
        totalTags <- rbind(totalTags,tags)
      }
    }
  
  
  Sys.sleep(0.3) # limit on how many reads
}





write.table(totalTags,file = filename ,append=FALSE,row.names=FALSE,col.names = FALSE)
