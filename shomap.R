#competencies mapping
require(igraph)

setwd("~/GitHub/Rtraining")

c <- read.csv2("data/competencies.csv")

ce <- read.csv2("data/competenciesedges.csv")

ceg <- graph.data.frame(ce)

V(ceg)

E(ceg)

plot(ceg)

V(ceg)$color <- "green"
V(ceg)[name %in% c$X]$color <- "red"

plot(ceg, layout=layout.circle)
plot(ceg, layout=layout.fruchterman.reingold)
plot(ceg, layout=layout.graphopt)
plot(ceg, layout=layout.kamada.kawai)

