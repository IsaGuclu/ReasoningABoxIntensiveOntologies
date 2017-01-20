options( java.parameters = "-Xmx8g" )
getwd()
setwd("C:/ProgramExt/WS-R/ABox/TrOWL_1941/")
getwd()

library(Boruta)
library(XLConnect)               # load XLConnect package 

wk = loadWorkbook("TrOWL_1941.xlsx") 
traindata = readWorksheet(wk, sheet="Combined143")

# traindata <- read.csv("train.csv", header = T, stringsAsFactors = F)  # This is for CLASSIFICATION. 
str(traindata)
summary(traindata)
traindata <- traindata[complete.cases(traindata),]
set.seed(777)
boruta.train <- Boruta(Materializing~., data = traindata, doTrace = 2, ntree=1000 )
print(boruta.train)
stats<-attStats(boruta.train);
print(stats);
print(getSelectedAttributes(boruta.train))

library(xlsx)
write.xlsx(stats, "Boruta-Combined143-1.xlsx")

detach("package:Boruta", TRUE)
detach("package:XLConnect", TRUE)
detach("package:xlsx", TRUE)


library(Boruta)
library(XLConnect)               # load XLConnect package 

wk = loadWorkbook("TrOWL_1941.xlsx") 
traindata = readWorksheet(wk, sheet="Combined143")

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

library(xlsx)
write.xlsx(stats, "Boruta-Combined143-2.xlsx")

detach("package:Boruta", TRUE)
detach("package:XLConnect", TRUE)
detach("package:xlsx", TRUE)


library(Boruta)
library(XLConnect)               # load XLConnect package 

wk = loadWorkbook("TrOWL_1941.xlsx") 
traindata = readWorksheet(wk, sheet="Combined143")

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

library(xlsx)
write.xlsx(stats, "Boruta-Combined143-3.xlsx")

detach("package:Boruta", TRUE)
detach("package:XLConnect", TRUE)
detach("package:xlsx", TRUE)
