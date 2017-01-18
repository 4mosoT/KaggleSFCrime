library(caret)
load("../crime_training.Rdata")
ctrl <- trainControl(method = "repeatedcv",number=10, repeats=3,classProbs=TRUE, summaryFunction=mnLogLoss)
formula <- Category ~ .
model_c50 <- train (formula, tuneLength=10, data=training, method='C5.0',trControl=ctrl, metric="logLoss", verbose = TRUE)
model_c50
save(model_c50, file="model_c50.Rdata")
