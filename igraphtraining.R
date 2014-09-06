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


# http://www.r-bloggers.com/network-visualization-in-r-with-the-igraph-package/
