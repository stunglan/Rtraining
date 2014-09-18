# word clod types of music
#install.packages("tm")
#install.packages("wordcloud")
library(plyr)
library(ggplot2)
library(tm)
library(wordcloud)


setwd("~/GitHub/Rtraining")



library(wordcloud)
library(RColorBrewer)

d <- read.table("data/words.csv",
                          header = TRUE,
                          sep = ",")

png("dnc.png")
wordcloud(d$words, # words
          d$freq, # frequencies
          scale = c(3,1), # size of largest and smallest words
          colors = brewer.pal(9,"Blues") # number of colors, palette
          ) # proportion of words to rotate 90 degrees
dev.off()

wordcloud(d$words,d$freq, scale=c(5,0.5), max.words=100, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE)
