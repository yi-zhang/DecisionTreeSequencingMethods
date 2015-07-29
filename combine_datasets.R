# install.packages('stringr')

datacsv<-read.table("SeqMeth_(3C AND chromosome).csv", sep=';')
data<-read.table("Test_specchar.txt", sep='\t')

files <-list.files(, pattern='*.csv',full.names=F, recursive=FALSE)

n=0
for(i in seq_along(files)){
    n=n+1
    print (n)
    path<-paste('Data_original/csv', files[i], sep='')
    data<-read.table(path, header=T) # load the file
    mydata <-rbind(data, mydata)
}
    