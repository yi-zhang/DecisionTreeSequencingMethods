# This scripts reads search expression from the csv and calls pubmed_search function 

library(RISmed)
library(dplyr)
print("start Pubmed search")
    con <-file("sequencing_methods.csv")
    data <- read.csv(con)[,3:4]
    close(con)

n=12  # starting point, e.g. 3 row in the csv file.
for (i in seq_along(data[,1])) {
    n=n+1
    print (paste('id: ', n, 'query: ', (data[n,2])))
    #print (paste('count', i, data[n]))
    if (n<15) {  # termination point, e.g. row 5 
        pubmed_search<-dget("pubmed_datafetch.R")
        pubmed_search(data[n,2], data[n,1]) 
    }
}
print("End Utilities")

