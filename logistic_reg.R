setwd("C:/Users/bxg190019/Desktop/mtg_dataset/Logistic_Regression")
# training data
mtg_dataset_train <- read.csv("mtg_dataset_train.csv", header = TRUE)
str(mtg_dataset_train)
mtg_dataset_train[is.na(mtg_dataset_train)] <- 0
mtg_dataset_train$LFT <- as.factor(mtg_dataset_train$LFT)
mtg_dataset_train$Win <- as.factor(mtg_dataset_train$Win)
ST_names <- c("opponent", "opponent_untapped_creature", "opponent_tapped_creature", "self", "self_untapped_creature", "self_tapped_creature" )
mtg_dataset_train$ST <- gsub("\\[|\\]", "", mtg_dataset_train$ST)
mtg_dataset_train$ST <- gsub("\\'|\\'", "", mtg_dataset_train$ST)

# OL = Opponent Life, OUC = Opponent Untapped Creature, OTC = Opponent Tapped Creature, SL = Self Life, SUC = Self Untapped Creature, STC = Self Tapped Creature
mtg_dataset_train$ST_OL <- 0
mtg_dataset_train$ST_OUC <- 0
mtg_dataset_train$ST_OTC <- 0
mtg_dataset_train$ST_SL <- 0
mtg_dataset_train$ST_SUC <- 0
# mtg_dataset_train$ST_STC <- 0

mtg_dataset_train$ST <- strsplit(mtg_dataset_train$ST, ", ")
for(i in 1:length(mtg_dataset_train$ST))
{
  mtg_dataset_train$ST_OL[i] <- sum(mtg_dataset_train$ST[i][[1]] == ST_names[1])
  mtg_dataset_train$ST_OUC[i] <- sum(mtg_dataset_train$ST[i][[1]] == ST_names[2])
  mtg_dataset_train$ST_OTC[i] <- sum(mtg_dataset_train$ST[i][[1]] == ST_names[3])
  mtg_dataset_train$ST_SL[i] <- sum(mtg_dataset_train$ST[i][[1]] == ST_names[4])
  mtg_dataset_train$ST_SUC[i] <- sum(mtg_dataset_train$ST[i][[1]] == ST_names[5])
  # mtg_dataset_train$ST_STC[i] <- sum(mtg_dataset_train$ST[i][[1]] == ST_names[6])
}

mtg_dataset_new <- mtg_dataset_train[,c(-1,-2,-7)]
game_logistic_new <- glm(Win ~ ., data = mtg_dataset_new, family = "binomial")
summary(game_logistic_new)

mtg_dataset_final <- mtg_dataset_new[,c(-2,-12,-14,-15)]
game_logistic_final <- glm(Win ~ ., data = mtg_dataset_final, family = "binomial")
summary(game_logistic_final)
table(mtg_dataset_final$Win)

# testing data
mtg_dataset_test <- read.csv("mtg_dataset_test.csv", header = TRUE)
str(mtg_dataset_test)
mtg_dataset_test[is.na(mtg_dataset_test)] <- 0
mtg_dataset_test$LFT <- as.factor(mtg_dataset_test$LFT)
mtg_dataset_test$Win <- as.factor(mtg_dataset_test$Win)
ST_names <- c("opponent", "opponent_untapped_creature", "opponent_tapped_creature", "self", "self_untapped_creature", "self_tapped_creature" )
mtg_dataset_test$ST <- gsub("\\[|\\]", "", mtg_dataset_test$ST)
mtg_dataset_test$ST <- gsub("\\'|\\'", "", mtg_dataset_test$ST)

# OL = Opponent Life, OUC = Opponent Untapped Creature, OTC = Opponent Tapped Creature, SL = Self Life, SUC = Self Untapped Creature, STC = Self Tapped Creature
mtg_dataset_test$ST_OL <- 0
mtg_dataset_test$ST_OUC <- 0
mtg_dataset_test$ST_OTC <- 0
mtg_dataset_test$ST_SL <- 0
mtg_dataset_test$ST_SUC <- 0
# mtg_dataset_test$ST_STC <- 0

mtg_dataset_test$ST <- strsplit(mtg_dataset_test$ST, ", ")
for(i in 1:length(mtg_dataset_test$ST))
{
  mtg_dataset_test$ST_OL[i] <- sum(mtg_dataset_test$ST[i][[1]] == ST_names[1])
  mtg_dataset_test$ST_OUC[i] <- sum(mtg_dataset_test$ST[i][[1]] == ST_names[2])
  mtg_dataset_test$ST_OTC[i] <- sum(mtg_dataset_test$ST[i][[1]] == ST_names[3])
  mtg_dataset_test$ST_SL[i] <- sum(mtg_dataset_test$ST[i][[1]] == ST_names[4])
  mtg_dataset_test$ST_SUC[i] <- sum(mtg_dataset_test$ST[i][[1]] == ST_names[5])
  # mtg_dataset_test$ST_STC[i] <- sum(mtg_dataset_test$ST[i][[1]] == ST_names[6])
}

mtg_dataset_test <- mtg_dataset_test[,c(-1,-2,-7)]
mtg_dataset_predict <- mtg_dataset_test[, c(-2,-12,-14,-15)]
levels(mtg_dataset_predict$LFT) <- c("FALSE","TRUE")
levels(mtg_dataset_predict$Win) <- c("FALSE","TRUE")
X <- predict(game_logistic_final, newdata = mtg_dataset_predict, type = "response")
Y <- as.factor(ifelse(X <= 0.5, "FALSE", "TRUE"))
table(Y, mtg_dataset_final$Win[1:8873])
