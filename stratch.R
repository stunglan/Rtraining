# igraph training
###### iGraph

#install.packages("igraph")
library(igraph)
library(tcltk)

igraphdemo("cohesive")
igraphdemo("centrality")
igraphdemo()

gd <- graph(as.factor(data$artist))
plot(gd)

el <- matrix( c("foo", "bar", "bar", "foobar"), nc=2, byrow=TRUE)
g13 <- graph.edgelist(el)
plot(g13)
el <- matrix(d)

karate <- graph.famous("Zachary")
karate.df <- get.data.frame(karate)

install.packages("gcookbook")
library(gcookbook)
str(madmen)
View(madmen)
m <- madmen[1:nrow(madmen) %% 2 == 1,]

# graph intro book

setwd("~/GitHub/Rtraining")

data <- read.csv2("data/graph1.csv",blank.lines.skip=T)
newdata = data[!apply(is.na(data) | data == "", 1, all), ]
data <- data[,2:3]

data.network<-graph.data.frame(data, directed=F)

V(data.network) #prints the list of vertices (people)
E(data.network) #prints the list of edges (relationships)
degree(data.network) #print the number of edges per vertex (relationships per people)

# First try. We can plot the graph right away but the results will usually be unsatisfactory:
plot(data.network)
