# This scripts reads search expression from the csv and calls pubmed_search function 
library(RISmed)
print("start Pubmed search")
    con <-file("sequencing_methods.csv")
    data <- read.csv(con)[,3]
n=3
for (i in seq_along(data)) {
    n=n+1
    print (paste('id: ', n, 'query: ', (data[n])))
    #print (paste('count', i, data[n]))
    if (n<6) {
        pubmed_search<-dget("pubmed_datafetch.R")
        pubmed_search(data[n]) 
    }
}
print("End Utilities")

