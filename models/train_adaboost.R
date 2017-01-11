library(caret)
library(doMC)
registerDoMC(cores = 2)
load("../crime_training.Rdata")
ctrl <- trainControl(method = "repeatedcv",number=5, repeats=3,classProbs=TRUE, summaryFunction=mnLogLoss)
formula <- Category ~ .
model_adaboost <- train (formula, tuneLength=10, data=training,method='AdaBoost.M1',trControl=ctrl, metric="logLoss", verbose = TRUE)
model_adaboost
save(model_adaboost, file="model_adaboost.Rdata")
