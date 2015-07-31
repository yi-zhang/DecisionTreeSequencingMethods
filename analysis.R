#Searches for regular expressions and creates variables
# str_count does not work with brackets, data must be clean of special characters. 
install.packages("data.table")
install.packages("stringr")
library(data.table)
library(stringr)
library(dplyr)
analyses<-function(file='Analys.csv', expression=''){
mydata<-read.csv("Analys.csv", header=TRUE)
}
n=0
jcount1<-data.frame()
a<-as.character(levels(a)) # list with journals
jc<-function(x){
    sumJ<-sum(str_count(as.character(mydata1[,4]), as.character(x)))
    n<<-n+1
    print (n)
    jcount1<<-rbind(jcount1, cbind(x,sumJ))
    #print(paste('Journal=', x, 'Sum=', sumJ))
}
lapply(a, jc) # use lapply to call function 

# Replace bracket from journal names
mydata1[,4]<-gsub('\\(', '', mydata1$Journal)

# shows journal distribution based on search terms in PubMed
jcount1<-jcount1 %>% arrange(desc(as.numeric(as.character(sumJ))), x)
#lapply(a, function(x) sum(str_count(mydata[,4], as.character(x))))

# provides number how often a specific term is in the data set
table(grepl('DNA|RNA', as.character(mydata1$Abstract)))
table(grepl('DNA && RNA', as.character(mydata1$Abstract)))
