# Combining search results into one file, merging that file with "impact factor" list. 
# Joerg Heintz
# August 20th, 2015

# collecting file and store then in a vector
files <-list.files('01_csv', pattern='*.csv',full.names=F, recursive=FALSE)

# loop over the vector and combine csv files into one file
mydata<-data.frame()
print ('start binding') 
for(i in seq_along(files)){
    print (paste('binding file', i))
    path<-paste('01_csv/', files[i], sep='')
    data<-read.csv2(path, header=T) # load the file
    mydata <-rbind(data, mydata)
}
## take out the redudandte journals
mydata<-mydata[!duplicated(mydata[,1]),]
print ('end binding file')


###### merge with journal impact factor list
# Joerg Heintz, August 18
library(dplyr)
library(plyr)
connect <-"2014_SCI_IF.csv"
rankedJournals<-read.csv(connect)[, c(1,2,3,5)]

## convert journal names into lower case, preparation for mapping 
b<-rankedJournals
b[,2]<-tolower(as.character(b[,2]))
colnames(b)[2]<-"Journal"

a<-read.csv("20150819_Analysis.csv")   # this file may have another name its name
a[,4]<-tolower(as.character(a[,4]))

mydata_merged<-arrange(join(a,b), Journal)
mydata_merged<-mydata_merged[,c(1,4,10,11,9,5,2,3,6,7,8)]

filename= paste(mydate, "_PaperDataBase", '.csv', sep='')
write.csv(mydata_merged, filename, row.names=FALSE)

##### end merge jounral impact factor list







#### writing into file
mydate<-Sys.Date()
filename= paste("search_results_combined_", mydate, '.csv', sep='')
write.csv(mydata, filename, row.names=FALSE)
write.csv(cleanDoubles, filename, row.names=FALSE)
