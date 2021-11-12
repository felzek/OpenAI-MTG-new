setwd("C:/Users/bxg190019/Desktop/mtg_dataset")
mtg_dataset <- read.csv("mtg_dataset.csv", header = TRUE)
str(mtg_dataset)
mtg_dataset[is.na(mtg_dataset)] <- 0
mtg_dataset$LFT <- as.factor(mtg_dataset$LFT)
mtg_dataset$Win <- as.factor(mtg_dataset$Win)
game_logistic <- glm(Win ~ OBC + SBC + OAC + SAC + OTC + STC + OUC + SUC + OLT + SLT + CP + LFT, data = mtg_dataset, family = "binomial")
summary(game_logistic)
game_logistic_red <- glm(Win ~ SBC + OAC + SAC + OTC + STC + OUC + SUC + OLT + SLT + LFT, data = mtg_dataset, family = "binomial")
summary(game_logistic_red)
ST_names <- c("opponent", "opponent_untapped_creature", "opponent_tapped_creature", "self", "self_untapped_creature", "self_tapped_creature" )
mtg_dataset$ST <- gsub("\\[|\\]", "", mtg_dataset$ST)
mtg_dataset$ST <- gsub("\\'|\\'", "", mtg_dataset$ST)

# OL = Opponent Life, OUC = Opponent Untapped Creature, OTC = Opponent Tapped Creature, SL = Self Life, SUC = Self Untapped Creature, STC = Self Tapped Creature
mtg_dataset$ST_OL <- 0
mtg_dataset$ST_OUC <- 0
mtg_dataset$ST_OTC <- 0
mtg_dataset$ST_SL <- 0
mtg_dataset$ST_SUC <- 0
# mtg_dataset$ST_STC <- 0

mtg_dataset$ST <- strsplit(mtg_dataset$ST, ", ")
for(i in 1:length(mtg_dataset$ST))
{
  mtg_dataset$ST_OL[i] <- sum(mtg_dataset$ST[i][[1]] == ST_names[1])
  mtg_dataset$ST_OUC[i] <- sum(mtg_dataset$ST[i][[1]] == ST_names[2])
  mtg_dataset$ST_OTC[i] <- sum(mtg_dataset$ST[i][[1]] == ST_names[3])
  mtg_dataset$ST_SL[i] <- sum(mtg_dataset$ST[i][[1]] == ST_names[4])
  mtg_dataset$ST_SUC[i] <- sum(mtg_dataset$ST[i][[1]] == ST_names[5])
  # mtg_dataset$ST_STC[i] <- sum(mtg_dataset$ST[i][[1]] == ST_names[6])
}

mtg_dataset_new <- mtg_dataset[,c(-1,-2,-7)]
game_logistic_new <- glm(Win ~ ., data = mtg_dataset_new, family = "binomial")
summary(game_logistic_new)