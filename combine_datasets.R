data<-read.table("Data/SeqMeth_BS-Seq.txt", sep='\t')

files <-list.files(path='DataDev/Data', pattern='*.txt',full.names=F, recursive=FALSE)
lapply(files, function(){
    t<-read.table(x, header=T) # load the file
    # apply function
    out <-function (t)
    # write to file
        write.table (out, "DataDev/", sep='\t', quote=F, row.names=F, col.names=T)
    
})


lapply(files, function(){
    a<-cbind(a, )
}

rbind(a.txt, b.txt)
