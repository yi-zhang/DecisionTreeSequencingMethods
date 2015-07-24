# This scripts reads search expression from the csv and calls pubmed_search function 
library(RISmed)
print("Start PubmedSearch")
    con <-file("sequencing_methods.csv")
    data <- read.csv(con)[,3]
n=21
for (i in seq_along(data)) {
    n=n+1
    #print (paste('count', i, data[n]))
    if (n<31) {
        pubmed_search<-dget("pubmed_search.R")
        pubmed_search(data[n])
        print (paste('id: ', i, 'query: ', (data[n])))
    }
}
print("End Utilities")

