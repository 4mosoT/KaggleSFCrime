#https://www.kaggle.com/c/sf-crime
#http://topepo.github.io/caret/model-training-and-tuning.html
#ftp://cran.r-project.org/pub/R/web/packages/caret/caret.pdf

####Kaggle Kernels####
#https://www.kaggle.com/keyshin/sf-crime/a-tiny-exploration/code
library(plyr)
library(dplyr)
library(ggmap)
library(ggplot2)
library(readr)
library(lubridate)
library(caret)

###Windows###
# library(doParallel) 
# cl <- makeCluster(detectCores())
# registerDoParallel(cl)

###Linux###
library(doMC)
registerDoMC(cores = 4)

#######################
### Start Functions ###
######################

map<-get_map(location="sanfrancisco", zoom= 12, color = "bw")


#coltypes <- list(Dates = col_datetime("%Y-%m-%d %H:%M:%S"))
#test <- read_csv("./input/test.csv.zip",  col_types=coltypes)
train <- read_csv("./input/train.csv.zip",  col_types=coltypes)



p <- ggmap(map) +
  geom_point(data=train, aes(x=X, y=Y, color=factor(PdDistrict)), alpha=0.05) +
  guides(colour = guide_legend(override.aes = list(alpha=1.0, size=6.0),
                               title="PdDistrict")) +
  scale_colour_brewer(type="qual",palette="Paired") + 
  ggtitle("Map of PdDistricts") +
  theme_light(base_size=20) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())

plot(p)




# map_crime <- function(crime_df, crime, map) {
#   filtered <- filter(crime_df, Category %in% crime)
#   plot <- ggmap(map, extent='device') + 
#     geom_point(data=filtered, aes(x=X, y=Y, color=Category), alpha=0.6)
#   return(plot)
# }
# 
# 
# density_map <- function(crime_df, crime, wrap,  map){
#   
# mapdata <-
#   crime_df %>%
#   filter(Category %in% crime)
# 
# contours <- stat_density2d(
#   aes(x = X, y = Y, fill = ..level.., alpha=..level..),
#   size = 0.1, data = mapdata, n=200,
#   geom = "polygon")
# 
# lims <- coord_map(xlim=c(-122.47, -122.37), ylim=c(37.70, 37.81))
# 
# 
#   ggmap(map, extent='device') + contours + lims +
#     scale_alpha_continuous(range=c(0.25,0.4), guide='none') +
#     facet_wrap(wrap) 
#     #scale_fill_gradient(paste(crime, collapse = '\n'))
# 
# }
# 
# 
# intervallH <- function(x) { 
# 
# if(x >= 0 & x < 5) y <- "NIGHT"
# if(x >= 5 & x < 9) y <- "PRE-JOB"
# if(x >= 9 & x < 13) y <- "MORNING"
# if(x >= 13 & x < 18) y <- "AFTERNOON"
# if(x >= 18 & x <= 24) y <- "EVENING"
# 
# return(y)
# }
# 
# #####################
# ### End Functions ###
# #####################
# 
# 
# 
# 
# #######################
# ### Preproccess    ###
# ######################
# 
# 
# train$Category <- make.names(train$Category)
# train <-
#   train %>%
#   mutate(Year  = factor(year(Dates), levels=2003:2015),
#          Month = factor(month(Dates), levels=1:12),
#          #Day   = day(Dates),
#          Hour  = hour(Dates),
#          #dayDate = as.POSIXct(round(Dates, units = "days")),
#          DayOfWeek = factor(DayOfWeek, levels=c("Monday",
#                                                 "Tuesday",
#                                                 "Wednesday",
#                                                 "Thursday",
#                                                 "Friday",
#                                                 "Saturday",
#                                                 "Sunday"))
#   )
# train$Address <- NULL                        
# train$Descript <- NULL
# train$Resolution <- NULL
# train$Dates <- NULL
# train["CatHour"] <- sapply(train$Hour,intervallH)
# train$Hour <- NULL
# 
# 
# train$Category <- factor(train$Category)
# train$PdDistrict<- factor(train$PdDistrict)
# train$CatHour<- factor(train$CatHour)
# #train$Hour <- factor(train$Hour)
# # train$Day <- factor(train$Day)
# 
# 
# dummies <- dummyVars( ~ . , data=train[,-1], sep= ':')
# train2 <- data.frame(predict(dummies, newdata = train))
# train2$Category <- train$Category
# train <- train2
# 
# 
# print(head(train))
# print(summary(train))
# 
# 
# density_map(train,c("ASSAULT"), ~ CatHour, map)
# 
# #######################
# ### Training       ###
# ######################
# # train_partition <- createDataPartition(y=train$Category, p=.2, list=FALSE)
# # training <- train[train_partition,]
# # summary(training)
# # testing <- train[-train_partition,]
# # print(nrow(training))
# # 
# # 
# # ctrl <- trainControl(method = "repeatedcv",number=10, repeats=3,classProbs=TRUE, summaryFunction=mnLogLoss)
# # 
# # formula <- Category ~ .
# 
# #modelknn <- train (formula, tuneLength=5, data=training,method='kknn',trControl=ctrl, metric="logLoss", verbose = TRUE)
# # model50 <- train (formula, tuneLength=5, data=training,method='C5.0',trControl=ctrl, metric="logLoss", verbose = TRUE)
# #modelsvm <- train (formula, tuneLength=5, data=training,method='cforest',trControl=ctrl, metric="logLoss", verbose = TRUE)
# #modellogistic <- train (formula, tuneLength=5, data=training,method='LogitBoost',trControl=ctrl, metric="logLoss", verbose = TRUE)
# 
# 
# 
# #results <- resamples(list(KNN=modelknn, Model50 = model50 ))
# # summarize the distributions
# #summary(results)
# # boxplots of results
# #bwplot(results)
# # dot plots of results
# #dotplot(results)
# 
# 
# #save(knnmodel, file="modelkknn.Rdata")
# 
# # Probs <- predict(Model, newdata = testing, type = "prob")
# # Classes <- predict(Model, newdata = testing, type = "raw")
# # Classes
# # confusionMatrix(data=nbClasses, testing$Category)
# 






