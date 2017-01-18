library(caret)
load("../crime_training.Rdata")
ctrl <- trainControl(method = "repeatedcv",number=5, repeats=3,classProbs=TRUE, summaryFunction=mnLogLoss)
formula <- Category ~ .
model_svm <- train (formula, tuneLength=10, data=training, method='svmLinear3',trControl=ctrl, metric="logLoss", verbose = TRUE)
model_svm
save(model_svm, file="model_svm.Rdata")