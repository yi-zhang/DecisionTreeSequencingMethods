### API nature protocols
### base URL  http://api.nature.com/content/opensearch
### endpoint for open search: http://api.nature.com/content/opensearch/request/


### libraries ###
library(httr)
library(jsonlite)

urlbase<-"http://api.nature.com/content/opensearch/request?"
apikey<-"&api_key=<API key string here>"
searchterm<-doi:10.1038/nprot.2015.086
ex1<-GET("http://api.nature.com/content/opensearch/request?queryType=searchTerms&query=nprot.2015.086&api_key=<gene>")
url1<-"http://api.nature.com/content/opensearch/request?queryType=cql&query=cql.keywords+any+darwin+OR+cql.keywords+any+lamarck&httpAccept=application/json&api_key=<API key string here>"
json1=content(ex1)
json2=jsonlite::fromJSON(toJSON(json1))
json2[1,]
json2
test<-data.frame()
test<-json2
