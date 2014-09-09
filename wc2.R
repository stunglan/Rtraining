# word clod types of music
#install.packages("tm")
#install.packages("wordcloud")
library(plyr)
library(ggplot2)
library(tm)
library(wordcloud)


setwd("~/GitHub/Rtraining")

# the corpus way

myCorpus <- Corpus(DirSource("data"),list(reader=readPDF))
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