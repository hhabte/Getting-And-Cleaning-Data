library(UCI HAR dataset)

filename <- "getdata_dataset.zip"

#Download and unzip the dataset to get data:
if (!file.exists(filename)){
  
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
  
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
 
#act=activity #sub=subjects  # Load activity labels and features  
  actlabels <- read.table("UCI HAR Dataset/act_labels.txt")
  
    actlabels[,2] <- as.character(actlabels[,2])

  features <- read.table("UCI HAR Dataset/features.txt")
  
    features[,2] <- as.character(features[,2])


#Load the datasets
  train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresinfo]
  
    trainact <- read.table("UCI HAR Dataset/train/Y_train.txt")
  
  trainsub <- read.table("UCI HAR Dataset/train/subject_train.txt")
  
    train <- cbind(trainsub, trainact, train)

  test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresinfo]

   testact <- read.table("UCI HAR Dataset/test/Y_test.txt")

  testsub <- read.table("UCI HAR Dataset/test/subject_test.txt")

    test <- cbind(testsub, testact, test)
  
  
#Extract only the measurements on the mean and standard deviation
  featuresinfo <- grep(".*mean.*|.*std.*", features[,2])

    featuresinfo.names <- features[featuresinfo,2]
  
      featuresinfo.names = gsub('-mean', 'Mean', featuresinfo.names)
  
    featuresinfo.names = gsub('-std', 'Std', featuresinfo.names)
  
      featuresinfo.names <- gsub('[-()]', '', featuresinfo.names)
  

#Merge the datasets and add the labels
  alldata <- rbind(train, test)
  
  columnnames(alldata) <- c("sub", "act", featuresinfo.names)


#Change subjects and activities into factors
  alldata$act <- factor(alldata$act, levels = actlabels[,1], labels = actlabels[,2])
  
    alldata$sub <- as.factor(alldata$sub)

  alldata.factor <- fact(alldata, id = c("subject", "activity"))
  
    alldata.mean <- dchange(alldata.factor, subj + act ~ variable, mean)


write.table(alldata.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
