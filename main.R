# This scripts reads search expression from the csv and calls pubmed_search function 
main<-function(start=2, en=3){
    library(RISmed)
    library(dplyr)
    
    # Retrievs method and search term from sequence_methods.csv using rownumbers start and end.
    print("========>>>>  retrieving search terms from sequencing_methods.csv")
    connect <-file("sequencing_methods.csv")
    search_term <- read.csv(connect)[start:en,3:4]
    Mnum<-start
    # loops through the search terms.
    for (n in seq_along(search_term[,1])) {
            # Call function to download the data set from pubmed        
            if (n<=en) {  # termination point, e.g. row 5 
                pubmed_search<-dget("pubmed_datafetch.R")
                Mnum<-start+n-1
                pubmed_search(search_term[n,2], search_term[n,1], Mnum) 
            }
            print("end retrieving search terms")
    }
    print("end PubMed search")
}


