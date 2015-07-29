### Code Book 
####Results  
1. search_results_combind_date.csv  
  1. Contains the search results of all 53 methods. 
  2. Variables are [PMID, Method, Search_Term, Journal, Citations, YearPubmed, Title	Abstract]
  2. The folder "01_csv" contains for each method the search result. 
  3. The folder "02_jpg" contain graphics that show the distribution of the methods over the journals
2. R Scripts
  3. main.R: reads the "method name" and the "search term" from sequencing_methods.csv and pass it to pubmned.datafetch.R
  4. pubmed_datafetch.R retrieves the search results from pubmed and store those in csv files 
  5. combine_datasets.R reads the stored csv files and combines them into one file "search_results_combined_date.csv

