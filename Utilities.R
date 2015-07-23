# Install pubmed.mineR
library(RISmed)
print("Start PubmedSearch")

    con <-file("sequencing_methods.csv")
    data <- read.csv(con)[,3]
n=0
for (i in seq_along(data)) {
    n=n+1
    print (paste('count', n, data[n]))
    if (n<53) {
        pubmed_search<-dget("pubmed_search.R")
        pubmed_search(data[n])
        #print (data[n])
    }
}
print("End Utilities")

