options( java.parameters = "-Xmx8g" )
getwd()
setwd("C:/ProgramExt/WS-R/ABox/ELK_1941/")
getwd()

library(Boruta)
library(XLConnect)               # load XLConnect package 

wk = loadWorkbook("ELK_1941.xlsx") 
traindata = readWorksheet(wk, sheet="Metrics92")

# traindata <- read.csv("train.csv", header = T, stringsAsFactors = F)  # This is for CLASSIFICATION. 
str(traindata)
summary(traindata)
traindata <- traindata[complete.cases(traindata),]
set.seed(777)
boruta.train <- Boruta(Materializing~., data = traindata, doTrace = 2, ntree=1000)
print(boruta.train)
stats<-attStats(boruta.train);
print(stats);
print(getSelectedAttributes(boruta.train))

detach("package:XLConnect", TRUE)

library(xlsx)
write.xlsx(stats, "Boruta-Metrics92-1.xlsx")

detach("package:xlsx", TRUE)
detach("package:Boruta", TRUE)



library(Boruta)
library(XLConnect)               # load XLConnect package 

wk = loadWorkbook("ELK_1941.xlsx") 
traindata = readWorksheet(wk, sheet="Metrics92")

# traindata <- read.csv("train.csv", header = T, stringsAsFactors = F)  # This is for CLASSIFICATION. 
str(traindata)
summary(traindata)
traindata <- traindata[complete.cases(traindata),]
set.seed(777)
boruta.train <- Boruta(Materializing~., data = traindata, doTrace = 2, ntree=1000)
print(boruta.train)
stats<-attStats(boruta.train);
print(stats);
print(getSelectedAttributes(boruta.train))

detach("package:XLConnect", TRUE)

library(xlsx)
write.xlsx(stats, "Boruta-Metrics92-2.xlsx")

detach("package:xlsx", TRUE)
detach("package:Boruta", TRUE)



library(Boruta)
library(XLConnect)               # load XLConnect package 

wk = loadWorkbook("ELK_1941.xlsx") 
traindata = readWorksheet(wk, sheet="Metrics92")

# traindata <- read.csv("train.csv", header = T, stringsAsFactors = F)  # This is for CLASSIFICATION. 
str(traindata)
summary(traindata)
traindata <- traindata[complete.cases(traindata),]
set.seed(777)
boruta.train <- Boruta(Materializing~., data = traindata, doTrace = 2, ntree=1000)
print(boruta.train)
stats<-attStats(boruta.train);
print(stats);
print(getSelectedAttributes(boruta.train))

detach("package:XLConnect", TRUE)

library(xlsx)
write.xlsx(stats, "Boruta-Metrics92-3.xlsx")

detach("package:xlsx", TRUE)
detach("package:Boruta", TRUE)
