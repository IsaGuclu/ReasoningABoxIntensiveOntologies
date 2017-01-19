options( java.parameters = "-Xmx8g" )
getwd()
setwd("C:/ProgramExt/WS-R/ABox/TrOWL_1941_FS/")
getwd()

library(randomForest)
library(XLConnect)               # load XLConnect package 

wk = loadWorkbook("TrOWL_1941.xlsx") 
data = readWorksheet(wk, sheet="Metrics92")

nrow(data) 

k = 5 #Folds

# sample from 1 to k, nrow times (the number of observations in the data)
data$id <- sample(1:k, nrow(data), replace = TRUE)
list <- 1:k  #  1  2  3  4  5

prediction <- data.frame()
testsetCopy <- data.frame()

# remove rows with id i from dataframe to create training set
# select rows with id i to create test set
trainingset <- subset(data, id %in% list[-1])
testset <- subset(data, id %in% c(1))
  
# run a random forest model
mymodel <- randomForest(Materializing ~ ., data = trainingset, ntree = 1000)
  
# remove response column 1, Sepal.Length
temp <- as.data.frame(predict(mymodel, testset[,-1]))
# append this iteration's predictions to the end of the prediction data frame
prediction <- rbind(prediction, temp)
  
# append this iteration's test set to the test set copy data frame
# keep only the Sepal Length Column
testsetCopy <- rbind(testsetCopy, as.data.frame(testset[,1]))

# add predictions and actual Sepal Length values
result <- cbind(prediction, testsetCopy[, 1])
names(result) <- c("Predicted", "Actual")
result$Difference <- abs(result$Actual - result$Predicted)

# As an example use Mean Absolute Error as Evalution 
summary(result$Difference)
# Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 

detach("package:XLConnect", TRUE)

# Export results to see;
# WHAT IS PREDICTED IN 10-FOLD CROS-VALIDATED RANDOM-FOREST REGRESSION
# And what is the ACCURACY ?
library(xlsx)
write.xlsx(result, "Results-Metrics92-1.xlsx")
detach("package:xlsx", TRUE)

library(randomForest)
library(XLConnect)               # load XLConnect package 

wk = loadWorkbook("TrOWL_1941.xlsx") 
data = readWorksheet(wk, sheet="Metrics92")

nrow(data) 

k = 5 #Folds

# sample from 1 to k, nrow times (the number of observations in the data)
data$id <- sample(1:k, nrow(data), replace = TRUE)
list <- 1:k  #  1  2  3  4  5

prediction <- data.frame()
testsetCopy <- data.frame()

# remove rows with id i from dataframe to create training set
# select rows with id i to create test set
trainingset <- subset(data, id %in% list[-1])
testset <- subset(data, id %in% c(1))
  
# run a random forest model
mymodel <- randomForest(Materializing ~ ., data = trainingset, ntree = 1000)
  
# remove response column 1, Sepal.Length
temp <- as.data.frame(predict(mymodel, testset[,-1]))
# append this iteration's predictions to the end of the prediction data frame
prediction <- rbind(prediction, temp)
  
# append this iteration's test set to the test set copy data frame
# keep only the Sepal Length Column
testsetCopy <- rbind(testsetCopy, as.data.frame(testset[,1]))

# add predictions and actual Sepal Length values
result <- cbind(prediction, testsetCopy[, 1])
names(result) <- c("Predicted", "Actual")
result$Difference <- abs(result$Actual - result$Predicted)

# As an example use Mean Absolute Error as Evalution 
summary(result$Difference)
# Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 

detach("package:XLConnect", TRUE)

# Export results to see;
# WHAT IS PREDICTED IN 10-FOLD CROS-VALIDATED RANDOM-FOREST REGRESSION
# And what is the ACCURACY ?
library(xlsx)
write.xlsx(result, "Results-Metrics92-2.xlsx")
detach("package:xlsx", TRUE)

library(randomForest)
library(XLConnect)               # load XLConnect package 

wk = loadWorkbook("TrOWL_1941.xlsx") 
data = readWorksheet(wk, sheet="Metrics92")

nrow(data) 

k = 5 #Folds

# sample from 1 to k, nrow times (the number of observations in the data)
data$id <- sample(1:k, nrow(data), replace = TRUE)
list <- 1:k  #  1  2  3  4  5

prediction <- data.frame()
testsetCopy <- data.frame()

# remove rows with id i from dataframe to create training set
# select rows with id i to create test set
trainingset <- subset(data, id %in% list[-1])
testset <- subset(data, id %in% c(1))
  
# run a random forest model
mymodel <- randomForest(Materializing ~ ., data = trainingset, ntree = 1000)
  
# remove response column 1, Sepal.Length
temp <- as.data.frame(predict(mymodel, testset[,-1]))
# append this iteration's predictions to the end of the prediction data frame
prediction <- rbind(prediction, temp)
  
# append this iteration's test set to the test set copy data frame
# keep only the Sepal Length Column
testsetCopy <- rbind(testsetCopy, as.data.frame(testset[,1]))

# add predictions and actual Sepal Length values
result <- cbind(prediction, testsetCopy[, 1])
names(result) <- c("Predicted", "Actual")
result$Difference <- abs(result$Actual - result$Predicted)

# As an example use Mean Absolute Error as Evalution 
summary(result$Difference)
# Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 

detach("package:XLConnect", TRUE)

# Export results to see;
# WHAT IS PREDICTED IN 10-FOLD CROS-VALIDATED RANDOM-FOREST REGRESSION
# And what is the ACCURACY ?
library(xlsx)
write.xlsx(result, "Results-Metrics92-3.xlsx")
detach("package:xlsx", TRUE)
