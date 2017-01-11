library(caret)
# library(doMC)
# registerDoMC(cores = 3)


load("crime_training.Rdata")
head(training)

ctrl <- trainControl(method = "repeatedcv",number=5, repeats=3,classProbs=TRUE, summaryFunction=mnLogLoss)
formula <- Category ~ .

model_c50 <- train (formula, tuneLength=10, data=training, method='C5.0',trControl=ctrl, metric="logLoss", verbose = TRUE)
model_c50
plot(model_c50)

model_knn <- train (formula, tuneLength=10, data=training,method='kknn',trControl=ctrl, metric="logLoss", verbose = TRUE)
model_knn
plot(model_knn)

model_adaboost <- train (formula, tuneLength=10, data=training,method='AdaBoost.M1',trControl=ctrl, metric="logLoss", verbose = TRUE)
model_adaboost
plot(model_adaboost)

model_rf <- train (formula, tuneLength=10, data=training,method='rf',trControl=ctrl, metric="logLoss", verbose = TRUE)
model_rf
plot(model_rf)

results <- resamples(list(KNN=model_knn, ModelC50 = model_c50 ))
summary(results)
bwplot(results)
dotplot(results)