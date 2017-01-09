library(caret)
library(mlbench)
data(Sonar)
names(Sonar)
set.seed(107)
inTrain <- createDataPartition(y=Sonar$Class,p=.75,list=FALSE)
str(inTrain)
training <- Sonar[inTrain,]
testing <- Sonar[-inTrain,]
nrow(training)
ldaModel <- train (Class ~ ., data=training,method="lda",preProc=c("center","scale"))
ldaModel
ctrl <- trainControl(method = "repeatedcv",repeats=3)
ldaModel3x10cv <- train (Class ~ ., data=training,method="lda",trControl=ctrl,
                         preProc=c("center","scale"))
ldaModel3x10cv

ctrl <- trainControl(method = "repeatedcv",repeats=3, classProbs=TRUE,
                     summaryFunction=twoClassSummary)
ldaModel3x10cv <- train (Class ~ ., data=training,method="lda",trControl=ctrl,metric="ROC",
                         preProc=c("center","scale"))
ldaModel3x10cv

plsFit3x10cv <- train (Class ~ ., data=training,method="pls",trControl=ctrl,metric="ROC",
                      preProc=c("center","scale"))
plsFit3x10cv
plot(plsFit3x10cv)
plsFit3x10cv <- train (Class ~ ., data=training,method="pls",trControl=ctrl,metric="ROC",
                       tuneLength=15,preProc=c("center","scale"))
plsFit3x10cv
plot(plsFit3x10cv)

plsProbs <- predict(plsFit3x10cv, newdata = testing, type = "prob")
plsClasses <- predict(plsFit3x10cv, newdata = testing, type = "raw")
confusionMatrix(data=plsClasses,testing$Class)

resamps=resamples(list(pls=plsFit3x10cv,lda=ldaModel3x10cv))
summary(resamps)
xyplot(resamps,what="BlandAltman")
diffs<-diff(resamps)
summary(diffs)