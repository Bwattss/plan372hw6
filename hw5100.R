library(tidyverse)
rawtrees = read.csv("TS3_raw_tree_data.csv")

#I need to create an expression to seperate city and state
State = str_match(rawtrees$City,"[:upper:]{2}")
Sity = str_match(rawtrees$City, "[:alpha:]+[:punct:]{1}")
rawtrees = cbind(rawtrees, State)
rawtrees = cbind(rawtrees, Sity)
unique(State) 
unique(Sity)

#how many records are there in each state
 statetrees = rawtrees %>% group_by(State) %>% count 
 statetrees = rename(statetrees, recordamounts = n)

 #filter data from NC and SC
 rawtrees = rawtrees %>% filter(State == "NC"| State == "SC")

 unique(rawtrees$Sity)
 
 #I need to separate out the genus 
genus = str_match(rawtrees$ScientificName, "[:alpha:]+[:space:]+") 

rawtrees = cbind(rawtrees, genus) 

#which genus tree has the largest crown 
NCcrowns = rawtrees %>% filter(State=="NC") %>% group_by(genus) %>% summarize(mean(AvgCdia..m.))
SCcrowns = rawtrees %>% filter(State=="SC") %>% group_by(genus) %>% summarize(mean(AvgCdia..m.))



