train.labeled <- read.delim("./Downloads/Kaggle_Data/labeledTrainData.tsv",header = T, quote = "", stringsAsFactors = F)
train.unlabeled <- read.delim("./Downloads/Kaggle_Data/unlabeledTrainData.tsv",
                              +                                header = T, quote = "", stringsAsFactors = F)
test <- read.delim("./Downloads/Kaggle_Data/testData.tsv",
                   +                     header = T, quote = "", stringsAsFactors = F)
all.data <- rbind(train.labeled[, -2], train.unlabeled, test)
all.data$sentiment <- c(train.labeled$sentiment,rep(NA, nrow(train.unlabeled) + nrow(test)))
train.labeled.ind <- 1:nrow(train.labeled)
train.ind <- 1:(nrow(train.labeled) + nrow(train.unlabeled))
test.ind <- (nrow(train.labeled) + nrow(train.unlabeled) + 1):nrow(all.data)
all.data$review.clean <- gsub("<.*?>", " ", all.data$review)
all.data$review.clean <- tolower(gsub("[[:punct:]]", "", all.data$review.clean))
afinn <- read.delim("./Downloads/Kaggle_Data/AFINN-111.txt",
                    +                      header = F, quote = "", stringsAsFactors = F)
names(afinn) <- c("word", "score")
afinn$word.clean <- gsub("-"," ", afinn$word)
afinn$word.clean <- gsub("[[:punct:]]", "", afinn$word.clean)
require(stringr)
tf <- t(apply(t(all.data$review.clean), 2,
              function(x) str_count(x, afinn$word.clean)))
require(e1071)
nb.model <- naiveBayes(sentiment~afinn.rating,
                       +                        data = all.data[train.labeled.ind, ])
nb.pred <- predict(nb.model,newdata = all.data[test.ind, ],type = "raw")