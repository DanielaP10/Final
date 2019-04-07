library(ape)
library(phyclust)
library(phytools)

## Simulation trees of equal branch length (br=0.5).

for (i in 1:3) {
  tree<-rtree(4,rooted = T,tip.label = c("T1","T2","T3","T4"), br = 1)
  write.tree(tree,file = paste("tree",i,".tre", sep=""))
}

treelist<-list.files(pattern = ".tre")

## Simulation sequences of equal branch length trees.

reps<-1:3

for (i in treelist) {
  arbolito  <-read.tree(i)
   for (g in reps) {
    seqgen(opts = "-mHKY, -l2000", rooted.tree = arbolito, temp.file = paste("mbre",i,g,".phy",sep=""))
  }

}   


## Change of one of the branch lenghts in the previus trees. Each branch of each tree were modified, one at a time. 

tree1<-read.tree("tree1.tre")
tree2<-read.tree("tree2.tre")
tree3<-read.tree("tree3.tre")

plot(tree1); nodelabels(); tiplabels()
plot(tree2); nodelabels(); tiplabels()
plot(tree3); nodelabels(); tiplabels()

br<-1:6

for (i in br) {
  tree1<-read.tree("tree1.tre")
  trbr1<-tree1$edge.length[i]<-1
  write.tree(tree1,file = paste("trbr1",i,".tree"))
}

for (i in br) {
  tree2<-read.tree("tree2.tre")
  trbr2<-tree2$edge.length[i]<-1
  write.tree(tree2,file = paste("trbr2",i,".tree"))
}

for (i in br) {
  tree3<-read.tree("tree3.tre")
  trbr3<-tree3$edge.length[i]<-1
  write.tree(tree3,file = paste("trbr3",i,".tree"))
}


## Sequence simulation of altered trees.

reps<-1:3

trbr1list<-list.files(pattern = ".tre")

for (i in trbr1list) {
  arbolito  <-read.tree(i)
  for (g in reps) {
    seqgen(opts = "-mHKY, -l2000", rooted.tree = arbolito, temp.file = paste("mtrbr1",i,g,".phy",sep=""))
  }
  
}  


trbr2list<-list.files(pattern = ".tre")

for (i in trbr2list) {
  arbolito  <-read.tree(i)
  for (g in reps) {
    seqgen(opts = "-mHKY, -l2000", rooted.tree = arbolito, temp.file = paste("mtrbr2",i,g,".phy",sep=""))
  }
  
}
