library(ape)
library(phytools)
library(picante)
library(ggplot2)
library(phangorn)

setwd("C:/Users/Papra/Documents/Comparadita/Laboratory/Final/Codigo/trees/trees")

dir.tree <- dir()

## Creat a empty list where we will put the trees.

trees <- list()

## Loop to put trees.

for (i in 1:length(dir.tree)){
  
  tree <- read.tree(dir.tree[i])
  trees[[i]] <- tree
  
}

names(trees) <- dir.tree

## Creat empty matrix to put distances.

distRF <- matrix(0, ncol = length(trees),nrow=length(trees))
colnames(distRF) <- dir.tree
rownames(distRF) <- dir.tree

## Loop to calculate RF distances.

for(j in 1:length(trees)){
  tree1 <- trees[[j]]
  allDF <- c()
  for(i in 1:length(trees)){
    tree2 <- trees[[i]]
    
    rf <- RF.dist(tree1, tree2)
    
    allDF <- c(allDF, rf)
  }
  
  distRF[j,] <- allDF
}

distRF

## Save distances matrix.

write.csv(distRF, file = "distanciasRF.csv")

## Distances between trees were added and put in a table organized by Method, metodh of the analysis; RF, RF distances; and Branch, branch lengths of the topologies. New archive calling RFdist.csv.

## Graphics of RF distances.

RFdist<-read.csv("RFdist.csv",sep = ";")

RFdist$Method <- as.factor(RFdist$Method)
RFdist$Branch <- as.factor(RFdist$Branch)

RFdist1 <- ggplot(RFdist, aes(x=RFdist$Method, y=RFdist$RF)) + 
  geom_boxplot(outlier.colour="red") + stat_summary(fun.y=mean, colour="seagreen", geom="point") + ylab("RF distance") + xlab("Method")

RFdist2 <- ggplot(RFdist, aes(x=as.numeric(RFdist$Branch), y=RFdist$RF, color=RFdist$Method)) + geom_point() + geom_smooth(method = lm, se=F) + ylab("RF distance") + xlab("Branch length")

