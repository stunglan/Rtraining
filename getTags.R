#getTags

#if (!exists('getTags_R')) {
getTags_R <-TRUE

setwd("~/GitHub/Rtraining")

getTags <- function() {
  
  data <- read.table("data/artistTags.csv",col.names=c("artist","tag","count"),stringsAsFactors = FALSE,na.strings = "NA")
  
  data <- unique(data)
  # END Fix DATA
}


#}