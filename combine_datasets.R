# Combining search results into on file

# collecting file and store then in a vector
files <-list.files('01_csv', pattern='*.csv',full.names=F, recursive=FALSE)

# loop over the vector and combine csv files into one file
mydata<-data.frame()
print ('start binding') 
for(i in seq_along(files)){
    print (paste('binding file', i))
    path<-paste('01_csv/', files[i], sep='')
    data<-read.csv(path, header=T) # load the file
    mydata <-rbind(data, mydata)
}
print ('end binding file')

#### writing into file
mydate<-Sys.Date()
filename= paste("search_results_combined_", mydate, '.csv', sep='')
write.csv(mydata, filename, row.names=FALSE)
