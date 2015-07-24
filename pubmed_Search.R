pubmed_search <- function(SearchExpression){
library(RISmed)
#library(Pubmed.mineR)
library(ggplot2)
print("Start Pubmed Search")

SearchExpression="(PEAT AND (sequence OR sequencing))"
# Search tag: sequencing method
query <- SearchExpression
print (paste("Start Retrieving Data:",query))
# Search Pubmed, retrieve complete record, subset record 
ngs_search <- EUtilsSummary(query, type="esearch",db = "pubmed",mindate=2000, maxdate=2015, retmax=30000)
QueryCount(ngs_search)
ngs_records <- EUtilsGet(ngs_search)
pubmed_data <- data.frame('PMID'=PMID(ngs_records), 'Citations'=Cited(ngs_records), 'YearPubmed'=YearPubmed(ngs_records), 'Journal'=MedlineTA(ngs_records), 'Title'=ArticleTitle(ngs_records),'Abstract'=AbstractText(ngs_records))
pubmed_data <- pubmed_data[order(-pubmed_data$YearPubmed, -pubmed_data$Citations),]
print (paste("End Retrieving Data:", query))

print("Preparing journal graphic")
# Overview how many articles per year, no journal information
years <- YearPubmed(ngs_records)
ngs_pubs_count <- as.data.frame(table(years))
print('Writing data into txt file')
# Filename for search results, store search results
filename= paste("SeqMeth_", query, '.txt', sep='')
write.table(pubmed_data,filename,quote=F,row.names=F, sep='\t')


# Selecting total publications, no journal differentiation
total <- NULL
for (i in 2000:2015){
    peryear <- EUtilsSummary("", type="esearch", db="pubmed", mindate=i, maxdate=i)
    total[i] <- QueryCount(peryear)
}
year <- 2000:2015
total_pubs_count<- as.data.frame(cbind(year,total[year]))
names(total_pubs_count) <- c("year","Total_publications")
names(ngs_pubs_count) <-  c("year","NGS_publications")
pubs_year <-  merge(ngs_pubs_count,total_pubs_count,by="year")
#write.table(pubs_year,"NGS_publications_per_year.txt",quote=F,sep="\t",row.names=F)

# Publications per journal
journal <- MedlineTA(ngs_records)
ngs_journal_count <- as.data.frame(table(journal))

a=25
if (nrow(ngs_journal_count) < 25) {
   a=nrow(ngs_journal_count)
}

ngs_journal_count_top25 <- ngs_journal_count[order(-ngs_journal_count[,2]),][1:a,]
journal_names <- paste(ngs_journal_count_top25$journal,"[jo]",sep="")

total_journal<-vector(mode="integer", length=25)
total_journal <- NULL
for (i in journal_names){
    perjournal <- EUtilsSummary(i, type='esearch', db='pubmed',mindate=2000, maxdate=2015)
    total_journal[i] <- QueryCount(perjournal)
}

journal_ngs_total <- cbind(ngs_journal_count_top25,total_journal)

names(journal_ngs_total) <- c("journal","NGS_publications","Total_publications")
#journal_ngs_total$NGS_publications_normalized <- journal_ngs_total$NGS_publications / journal_ngs_total$Total_publications


print ("Writing graphic as jpb")
xaxes<-paste('publication on', query)
write.table(journal_ngs_total,"NGS_publications_per_journal.txt",quote=F,sep="\t",row.names=F)
pubs_per_journal <- read.table("NGS_publications_per_journal.txt",header = T,sep="\t")
jp<-ggplot(pubs_per_journal,aes(journal, NGS_publications, fill=journal)) + geom_bar(stat="identity")+
    coord_flip()+
    theme(legend.position="none")

# Filename for plot 
journalplot= paste("SeqMeth_", query, '_journalplot', '.jpg', sep='')
ggsave(journalplot, jp)
print ("End of Pubmed Search")
}

