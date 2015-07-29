pubmed_search <- function(SearchExpression, MethodName){
library(RISmed)
library(ggplot2)
library(dplyr)
print("start PubMed search")

# Search tag: sequencing method
query <- SearchExpression
MethodName<-MethodName
#query <- "(PEAT AND (sequence OR sequencing) AND method)"
#MethodName<-"PEAT"

# Search Pubmed, retrieve complete record, subset record 
print (paste("start retrieving data on: ", MethodName, " search expression: " ,query))
print (Sys.time())
ngs_search <- EUtilsSummary(query, type="esearch",db = "pubmed",mindate=2000, maxdate=2015, retmax=30000)
QueryCount(ngs_search)
print (paste('query results:', QueryCount(ngs_search)))
ngs_records <- EUtilsGet(ngs_search)
print (Sys.time())
print (paste("ngs record retrieved"))
print (ngs_records)
print (Sys.time())
pubmed_data <- data.frame('PMID'=PMID(ngs_records), 'Citations'=Cited(ngs_records), 'YearPubmed'=YearPubmed(ngs_records), 'Journal'=MedlineTA(ngs_records), 'Title'=ArticleTitle(ngs_records),'Abstract'=AbstractText(ngs_records))
#pubmed_data <- pubmed_data[order(-pubmed_data$YearPubmed, -pubmed_data$Citations),]
print (Sys.time())
print (paste("pubmed dataframe generated"))
pubmed_data <- pubmed_data %>% mutate(Method = MethodName, Search_Term = query) %>% select(PMID, Method, Search_Term, Journal, Citations, YearPubmed, Title, Abstract)  %>% arrange(-YearPubmed, -Citations)
print (paste("end retrieving data:", query))


# Overview how many articles per year, no journal information
print("Preparing journal graphic")
years <- YearPubmed(ngs_records)
ngs_pubs_count <- as.data.frame(table(years))
print('writing data into csv file')

# Filename for search results, store search results
filename2= paste(MethodName, '.csv', sep='')
#write.table(pubmed_data,filename,quote=F,row.names=F, sep='\t')
write.table(pubmed_data, filename2, row.names=FALSE,sep=";")

# Total publications, no journal differentiation
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


print ("writing graphic as jpg")
xaxes<-paste('publication on', query)
########  Needs improvement !!!  awkward solution ####### Joerg, 7/24/2015
write.table(journal_ngs_total,"NGS_publications_per_journal.txt",quote=F,sep="\t",row.names=F)
pubs_per_journal <- read.table("NGS_publications_per_journal.txt",header = T,sep="\t")
jp<-ggplot(pubs_per_journal,aes(journal, NGS_publications, fill=journal)) + geom_bar(stat="identity")+
    coord_flip()+
    theme(legend.position="none")


# Save plot
journalplot= paste("SeqMeth_", query, '_journalplot', '.jpg', sep='')
ggsave(journalplot, jp)
print ("end of Pubmed search")
}







