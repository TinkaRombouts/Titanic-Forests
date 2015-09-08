library(readr)
library(dplyr)
library(stringr)

train <- read_csv("data/train.csv") %>%
    mutate(Title = as.factor(str_extract(Name, "[A-Za-z\\-]+\\.")),
           Age = as.integer(Age),
           Family = as.factor(str_extract(Name, "^[A-Za-z\\-' ]+")),
           NoCabins = sapply(strsplit(Cabin, " "), length)) %>%
    select(PassengerId, Survived, NoCabins, Pclass, Family, SibSp, Title, Name, Sex:Embarked) %>%
    arrange(Family, SibSp)

write_csv(train, "data/train_analysis.csv", col_names = TRUE)
