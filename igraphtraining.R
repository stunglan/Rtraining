# lastfm
#create graph over transitions
library(plyr)
require(igraph)
setwd("~/GitHub/Rtraining")

source("getPlays.R")
source("getTags.R")

# get lastfm data

data <- getPlays()
tags <- getTags()

# end graph over most popular tags and their artists


tags <- tags[c("tag","artist","count")]

data.topartists <- count(data,c("artist"))
data.topartists <- data.topartists[order(data.topartists$freq,decreasing=T),]
data.topartists <- head(data.topartists,20)

data.toptags <- subset(tags,artist %in% data.topartists$artist)

data.g <-graph.data.frame(data.toptags, directed=F)

# Inspect the data:

V(data.g) #prints the list of vertices (people)
E(data.g) #prints the list of edges (relationships)
degree(data.g) #print the number of edges per vertex (relationships per people)

V(data.g)$color <-  ifelse(V(data.g)$name %in% data.toptags$tag,"blue","green") 

V(data.g)$color <- if(V(data.g)$name=='The White Stripes', 'red') 

E(data.g)$color <- ifelse(E(data.g)$V1>2, "red", "grey")

# First try. We can plot the graph right away but the results will usually be unsatisfactory:
par(mai=c(0,0,1,0)) 
plot(data.g,
     layout=layout.fruchterman.reingold,)


# 



# end graph over most popular tags and their artists

data.a <- data[c("artist","nextartist","month")]
data$nextartist <- data$artist

nrow(data)

data.topartists <- count(data.a,c("artist"))
data.topartists <- data.topartists[order(data.topartists$freq,decreasing=T),]
data.topartists <- head(data.topartists,20)


data.a <- subset(data.a, artist %in% data.topartists$artist)


for (i in 1:(nrow(data.a)-1)) {
  data.a$nextartist[i] <- data.a$artist[i+1]
} 



data.count <- count(data.a,c("artist","nextartist"))



#data.ap <- head(data.ap,100)


data.g <-graph.data.frame(data.count, directed=F)

# Inspect the data:

V(data.g) #prints the list of vertices (people)
E(data.g) #prints the list of edges (relationships)
degree(data.g) #print the number of edges per vertex (relationships per people)

V(data.g)$color<-ifelse(V(data.g)$name=='The White Stripes', 'red', 'grey') 
E(data.g)$color<-ifelse(E(data.g)$V1>2, "red", "grey")

# First try. We can plot the graph right away but the results will usually be unsatisfactory:
par(mai=c(0,0,1,0)) 
plot(data.g,
     layout=layout.fruchterman.reingold,)

