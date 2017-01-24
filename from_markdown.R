library(plyr)
library(dplyr)
library(ggmap)
library(ggplot2)
library(readr)
library(lubridate)
library(caret)
library(knitr)
library(stringr)



train <- read_csv("./input/train.csv.zip")
#test <- read_csv("./input/train.csv.zip")

train$Resolution <- NULL
train$Descript <- NULL

options(dplyr.width = Inf)
kable(head(train))
summary(train)

sort(table(train$Category), decreasing = TRUE)

train <- mutate(train,
                Year = factor(year(Dates), levels = 2003:2015), 
                Month = factor(month(Dates), levels = 1:12), 
                Day = factor(day(Dates), levels = 1:31),
                Hour = factor(hour(Dates), levels = 0:23),
                DayOfWeek = factor(DayOfWeek, levels=c("Monday",
                                                       "Tuesday",
                                                       "Wednesday",
                                                       "Thursday",
                                                       "Friday",
                                                       "Saturday",
                                                       "Sunday"))
)
train$Dates <- NULL

# test <- mutate(test,
#                 Year = factor(year(Dates), levels = 2003:2015), 
#                 Month = factor(month(Dates), levels = 1:12), 
#                 Day = factor(day(Dates), levels = 1:31),
#                 Hour = factor(hour(Dates), levels = 0:23),
#                 DayOfWeek = factor(DayOfWeek, levels=c("Monday",
#                                                   "Tuesday",
#                                                   "Wednesday",
#                                                   "Thursday",
#                                                   "Friday",
#                                                   "Saturday",
#                                                   "Sunday"))
#                 )
# test$Dates <- NULL





train$ShortAddr <- word(train$Address, start=-2, end=-1)
#test$ShortAddr <- word(test$Address, start=-2, end=-1)
#train$Address <- NULL


kable(head(train[,-6:-1]))


dummies <- dummyVars( ~ Hour + DayOfWeek, data = train)
dummy_train <- data.frame(predict(dummies, newdata= train))
dummy_train$Category <- train$Category
dummy_train$X <- train$X
dummy_train$Y <- train$Y
train <- dummy_train


#Construcción del modelo

train$Category <- make.names(train$Category)

train_partition <- createDataPartition(y=train$Category, p=.001, 
list=FALSE)
training <- train[train_partition,]
testing <- train[-train_partition,]
save(training, file='crime_training.Rdata' )
save(testing, file='crime_testing.Rdata')

