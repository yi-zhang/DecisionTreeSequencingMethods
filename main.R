# This scripts reads search expression from the csv and calls pubmed_search function 
main<-function(start=1, en=3){
print(paste('Start:', start, " End:", en))
library(RISmed)
library(dplyr)
print("start Pubmed search")
    con <-file("sequencing_methods.csv")
    data <- read.csv(con)[,3:4]
m=start
# starting point, e.g. 3 row in the csv file.
for (n in seq_along(data[,1])) {
    if (n>=m ) {
    print (paste('id:', n, 'query: ', (data[n,2])))
    #print (paste('count', i, data[n]))
    if (n<=en) {  # termination point, e.g. row 5 
        pubmed_search<-dget("pubmed_datafetch.R")
        pubmed_search(data[n,2], data[n,1]) 
    }
    }
}
print("End Utilities")
}


