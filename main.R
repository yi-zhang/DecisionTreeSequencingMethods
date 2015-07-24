# This scripts reads search expression from the csv and calls pubmed_search function 
library(RISmed)
print("start Pubmed search")
    con <-file("sequencing_methods.csv")
    data <- read.csv(con)[,3]
n=3  # starting point, e.g. 3 row in the csv file.
for (i in seq_along(data)) {
    n=n+1
    print (paste('id: ', n, 'query: ', (data[n])))
    #print (paste('count', i, data[n]))
    if (n<6) {  # termination point, e.g. row 5 
        pubmed_search<-dget("pubmed_datafetch.R")
        pubmed_search(data[n]) 
    }
}
print("End Utilities")

