# getwd()
# setwd('C:/Users/ifrat/Dropbox/R/Coursera/getting and cleaning data/Data Cleaning Project')
require(dplyr)

rm(list = ls())
#read features and activities names into R
features<-read.table('features.txt',stringsAsFactors = F)
activities<- read.table('activity_labels.txt')
names(activities)<-c("id","activity.name")
#the following function formats the test/train data sets so that we can
#merge them later
fitdatacleanup<- function(folder){
    #reads data into R
    sub<- read.table(paste0(folder,'/subject_',folder,'.txt'))
    x<- read.table(paste0(folder,'/X_',folder,'.txt'))
    y<- read.table(paste0(folder,'/y_',folder,'.txt'))

    #Names Columns
    names(sub)<-"subject"
    names(x)<-features$V2
    names(y)<- "activity"

    #mearge datasets
    y<- left_join(y,activities, by = c("activity"="id"))
    testdata<- cbind(sub,y,x)

    testdata<-testdata[,grepl("mean|std|subject|activity\\.name"
                              ,names(testdata))]
    testdata$dataset<-folder
    testdata
}
alldata<- rbind(fitdatacleanup("test"),fitdatacleanup("train"))

##make col names more descriptive
names(alldata)<- make.names(names(alldata))
names(alldata)<- gsub("^t","time\\.",names(alldata))
names(alldata)<- gsub("^f","frequency\\.",names(alldata))
names(alldata)<- gsub("Acc",".accelerometer\\.",names(alldata))
names(alldata)<- gsub("Gyro",".gyroscope\\.",names(alldata))
names(alldata)<- gsub("Mag",".magnitude\\.",names(alldata))
names(alldata)<- gsub("\\.{1,}","\\.",names(alldata))
names(alldata)<- tolower(names(alldata))
names(alldata)<- gsub("\\.$","",names(alldata))

alldatasum<-subset(alldata, select = -dataset)%>%
    group_by(activity.name,subject)%>%
    summarise_all(funs(mean),na.rm = T)
write.csv(alldatasum,"tidydata.csv",row.names = F, na = "")
