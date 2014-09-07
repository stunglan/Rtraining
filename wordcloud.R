# word clod types of music
#install.packages("tm")
#install.packages("wordcloud")
library(plyr)
library(ggplot2)
library(tm)
library(wordcloud)


setwd("~/GitHub/Rtraining")

source("getTags.R")
source("getPlays.R")


tags <- getTags()


# the corpus way
myCorpus <- Corpus(VectorSource(tags$tag))
myCorpus <- tm_map(myCorpus,tolower)

print(myCorpus)
inspect(myCorpus[1:4])

dtm <- DocumentTermMatrix(myCorpus)
m <- as.matrix(dtm)
v <- sort(colSums(m),decreasing=TRUE)
head(v,14)
words <- names(v)
d <- data.frame(word=words, freq=v)

wordcloud(d$word,d$freq,min.freq=50)

wordcloud(words, scale=c(5,0.5), max.words=100, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE)
# manual

songs <- getPlays()
artists <- tolower(songs$artist)
d <-count(artists)
# remove specific rows
d <- subset(d,x != "nrk p2")

d <- d[order(d$freq,decreasing=T),]

d <- head(d,100)


wordcloud(d$x,d$freq,min.freq=10,random.order=FALSE) 
wordcloud(d$x,d$freq,min.freq=10,random.order=FALSE,scale=c(5,0.5), max.words=100) 

require(RColorBrewer)
  pal <- brewer.pal(9,"RdBu")
  pal <- pal[-(1:4)]
  wordcloud(d$x,d$freq,c(5,.2),2,,FALSE,,.15,pal)
  pal <- brewer.pal(6,"Paired")
  pal <- pal[-(1)]
  wordcloud(d$x,d$freq,c(5,.2),2,,TRUE,,.15,pal)
  #random colors
  wordcloud(d$x,d$freq,c(5,.2),2,,TRUE,TRUE,.15,pal)

