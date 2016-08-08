library(UCI HAR dataset)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
 
# Load activity labels and features  #act=activity #sub=subjects
actLabels <- read.table("UCI HAR Dataset/act_labels.txt")
actLabels[,2] <- as.character(actLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
featuresInfo <- grep(".*mean.*|.*std.*", features[,2])
featuresInfo.names <- features[featuresInfo,2]
featuresInfo.names = gsub('-mean', 'Mean', featuresInfo.names)
featuresInfo.names = gsub('-std', 'Std', featuresInfo.names)
featuresInfo.names <- gsub('[-()]', '', featuresInfo.names)


# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresInfo]
trainAct <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSub, trainAct, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testAct <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSub, testAct, test)

# merge datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("sub", "act", featuresInfo.names)

# turn activities & subjects into factors




write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
