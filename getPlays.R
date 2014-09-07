#getPlays

#if (!exists('getPlays_R')) {
  getPlays_R <-TRUE
  
  setwd("~/GitHub/Rtraining")
  
  getPlays <- function() {
    
    data <- read.table("data/recentplays.csv",col.names=c("name","album","artist","uts","year","month","day","hour"),stringsAsFactors = FALSE,na.strings = "NA")
    
    data <- subset(data,grepl("[01-9]{10,10}",uts)) # remove invalid uts
    
    data <- transform(data,
                      time = as.POSIXlt(as.numeric(uts),origin = "1970-01-01")
    )
    
    data <- transform(data,
                      hourOnly = format(time, format = "%H")
    )
    data <- transform(data,
                      monthOnly = format(time, format = "%m")
    )
    
    data <- data[order(data$time),]
    
    #data2 <- data[duplicated(data),]
    data <- unique(data)
    # END Fix DATA
  }
  
  
#}