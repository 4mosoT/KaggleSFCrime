library(caret)
library(doMC)
registerDoMC(cores = 2)
load("../crime_training.Rdata")
ctrl <- trainControl(method = "repeatedcv",number=5, repeats=3,classProbs=TRUE, summaryFunction=mnLogLoss)
formula <- Category ~ .
model_rf <- train (formula, tuneLength=10, data=training,method='rf',trControl=ctrl, metric="logLoss", verbose = TRUE)
model_rf
save(model_rf, file="model_rf.Rdata")
