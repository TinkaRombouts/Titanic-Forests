library(readr)
library(dplyr)
library(stringr)

train <- read_csv("data/train.csv") %>%
    mutate(Title = as.factor(str_extract(Name, "[A-Za-z\\-]+\\.")),
           Age = as.integer(Age),
           Family = as.factor(str_extract(Name, "^[A-Za-z\\-' ]+")),
           NoCabins = sapply(strsplit(Cabin, " "), length),
           Deck = str_extract(Cabin, "\\b[:alpha:]")) %>%
    mutate(Deck = sapply(Deck, function(x){ ifelse(length(x)==0,NA,x) })) %>%
    select(PassengerId:Pclass, Deck, NoCabins, Title,
           Family, SibSp, Name, Sex:Embarked) %>%
    arrange(Ticket, Family, SibSp)

write_csv(train, "data/train_analysis.csv", col_names = TRUE)
