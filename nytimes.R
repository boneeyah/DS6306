library(dplyr)
library(tidyr)
library(plyr)
library(jsonlite)
library(ggplot2)
library(tm)
library(stringr)

key <- "7tl75iH7w2vOJJUBosFdtNyVhAzBKD2E"

term <- "El Salvador"
begin_date <- "20210101"
end_date <- "20220128"

baseurl <-paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,"&begin_date=",begin_date,"&end_date=",end_date,"&facet_filter=true&api-key=",key, sep="")
baseurl
initialQuery <- fromJSON(baseurl)

maxPages <- round((initialQuery$response$meta$hits[1]/10)-1)
pages <- list()
for (i in 0:maxPages) {
  nytsearch <- fromJSON(paste0(baseurl,"&page=",i),flatten = TRUE) %>% data.frame()
  message("Retrieving page ",i)
  pages[[i+1]] <- nytsearch
  Sys.sleep(6)
  
}
allnytsearch <- rbind_pages(pages)


allnytsearch %>% 
  group_by(response.docs.type_of_material) %>% dplyr::summarise(count = n()) %>% 
  mutate(percent = (count / sum(count)*100)) %>% 
  ggplot()+
  geom_bar(aes(y = percent, x = response.docs.type_of_material, fill=response.docs.type_of_material), stat = "identity")

articletoclass <- allnytsearch[5,]
truetype <- allnytsearch$response.docs.type_of_material[5]

allnytsearch$NewsorOther <-  if_else(allnytsearch$response.docs.type_of_material == "News", "News", "Other")

stopwords()
thetext=unlist(str_split(str_replace_all(articletoclass$response.docs.headline.main,"[^[:alnum:] ]", ""), boundary("word")))

wwords <- c(stopwords(), "El", "Salvador")

NewsArticles <- allnytsearch %>% filter(NewsorOther=="News")
OtherArticles <- allnytsearch %>% filter(NewsorOther=="Other")
wwords <- str_c(wwords, collapse = "\\b|\\b")
wwords <- str_c("\\b", wwords,"\\b")
numnews <- dim(NewsArticles)[1]
numother <- dim(OtherArticles)[1]
numall <- dim(allnytsearch)[1]
wwordstay
wwordstay <- thetext[!str_detect(thetext, regex(wwords,ignore_case = TRUE))]
percentholdernews <- c()
percentholderother <- c()

wwordstay[3]
nnews <- sum(str_count(NewsArticles$response.docs.headline.main[-5],wwordstay[3]))
nother <- sum(str_count(OtherArticles$response.docs.headline.main[-5],wwordstay[2]))
percentholdernews[1]=numnews/numall
percentholderother[1]=numother/numall

percentholdernews
percentholderother
for (i in 1:length(wwordstay)) {
  nnews <- sum(str_count(NewsArticles$response.docs.headline.main[-5],wwordstay[5]))
  nother <- sum(str_count(OtherArticles$response.docs.headline.main[-5],wwordstay[5]))
  percentholdernews[i]=numnews/numall
  percentholderother[i]=numother/numall
  
  percentholdernews
  percentholderother
}
sum(percentholdernews)
sum(percentholderother)
percentholdernews

astat <- data.frame(wordd = wwordstay, newscore = percentholdernews, otherscor=percentholderother)

astat[,c(2,3)] %>% gather(Type,Percent) %>% mutate(Word =rep(astat$wordd)) %>% ggplot(aes(x = Type, y = Percent, fill = Word))+geom_col()+facet_grid(~Word)
?rep
