# Packages
library(proxy)
library(igraph)

# Import and Cleaned Data
data1<-read.csv("transaction_table.csv",header = TRUE)
jaccard<-data1[,c(1,5)]
jaccard<-na.omit(jaccard)

## Build affiliation matrix to calculate Jaccard distance for each customer
g<-graph.data.frame(jaccard, directed=TRUE)
V(g)$type <- bipartite_mapping(g)$type
bipartite_matrix <- data.frame(as_incidence_matrix(g))
dis<-as.matrix(dist(bipartite_matrix,'Jaccard'))
similar<-1-dis

write.csv(similar, file = "result.csv")
