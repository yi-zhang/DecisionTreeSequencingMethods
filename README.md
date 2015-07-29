#### Code Book 
##### Results  
1. Research results of all 53 methods are stored in "search_results_combind_date.csv"
2. Variables are [PMID, Method, Search_Term, Journal, Citations, YearPubmed, Title	Abstract]
2. The folder "01_csv" contains for each method the search result. 
3. The folder "02_jpg" contain for each method the distribution " method over journals" [jpg-format]

##### R Scripts
1. main.R: reads the "method name" and the "search term" from sequencing_methods.csv and pass it to pubmned.datafetch.R
2. pubmed_datafetch.R retrieves the search results from pubmed and store those in csv files 
3. combine_datasets.R reads the stored csv files and combines them into one file "search_results_combined_date.csv
