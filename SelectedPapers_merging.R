# Mapping impact factor jounals of selected papers
# Joerg Heintz, August 18
library(dplyr)
library(plyr)
connect <-"2014_SCI_IF.csv"
rankedJournals<-read.csv(connect)[, c(1,2,3,5)]

## convert journal names into lower case, preparation for mapping 
b<-rankedJournals
b[,2]<-tolower(as.character(b[,2]))
colnames(b)[2]<-"Journal"

a<-read.csv("20150819_Analysis.csv")
a[,4]<-tolower(as.character(a[,4]))

mydata_merged<-arrange(join(a,b), Journal)
mydata_merged<-mydata_merged[,c(1,4,10,11,9,5,2,3,6,7,8)]

filename= paste(mydate, "_analysis_merged", '.csv', sep='')
write.csv(mydata_merged, filename, row.names=FALSE)
