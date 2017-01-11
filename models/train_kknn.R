library(caret)
library(doMC)
registerDoMC(cores = 2)
load("../crime_training.Rdata")
ctrl <- trainControl(method = "repeatedcv",number=5, repeats=3,classProbs=TRUE, summaryFunction=mnLogLoss)
formula <- Category ~ .
knngrid <- expand.grid(kmax=c(3,5,7,9,15,20), distance=c(1,2), kernel=c('gaussian', 'optimal', 'inv'))
model_knn <- train (formula, tuneGrid = knngrid, data=training,method='kknn',trControl=ctrl, metric="logLoss", verbose = TRUE)
model_knn
save(model_knn, file="model_knn.Rdata")

# results <- resamples(list(KNN=model_knn, ModelC50 = model_c50 ))
# summary(results)
# bwplot(results)
# dotplot(results)