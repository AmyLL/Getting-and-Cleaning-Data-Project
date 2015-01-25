
#----------------------- GET REQUIRED FEATURES AND IDS FOR SUBSETTING DATASETS--------------
#read features file to get column names
#NOTE: the features file associated with the data set contained dashes, parentheses and commas
#These were removed from the file and Capitol letters inserted for spacing
#This data set is supplied as featuresMod.txt


features <- read.table("./featuresMod.txt", header = FALSE)
dim(features)
#dim(features = 561 rows x 2 columns)


#retrieve indices which contain either means or std deviations
#Generate a new column ("Column of Interest") which is TRUE if the data contains a mean or std. dev.
features[grep("Mean",features$V2), "colOfInt"] <- as.logical(TRUE)
features[grep("Std", features$V2), "colOfInt"] <- as.logical(TRUE)
reqFeatures <- subset(features, features$colOfInt == TRUE)
#Generate a list of columns to keep in the train dataset
keepCols <- select(reqFeatures, V1)

#Rename the columns in the dataset and transpose
newColNames <-subset(reqFeatures, select = "V2")
newNames <- t(newColNames[1])

#Get the subject index for the rows of the datasets
idTrain <- read.table("./train/subject_train.txt")
idTest <- read.table("./test/subject_test.txt")
id <- c(ID)
colnames(idTest) <- id
colnames(idTrain) <- id

#------------------- GET DATA, SUBSET, RENAME COLUMNS ---------------------------------
#Get X_train and X_test datasets and subset to keep only the necessary columns

trainData <- read.table("./train/X_train.txt")
reqTrainData <- select(trainData, keepCols$V1)
testData <- read.table("./test/X_test.txt")
reqTestData <- select(testData, keepCols$V1)

#rename the column variables 
colnames(reqTrainData) <- newNames
colnames(reqTestData) <- newNames

#-------------- ADD SUBJECT IDS, COMBINE, AND WRITE COMBINED DATASET TO FILE --------------

#Add subject IDs to the beginning of the datasets
reqTrainData <- cbind(idTrain, reqTrainData)
reqTestData <- cbind(idTest, reqTestData)

#combine the datasets: add rows of Test Data to Train Data
combined <- rbind(reqTrainData, reqTestData)

#--------------- ADD ACTIVITY LABELS --------------------------------

activityTest <- read.table("./test/y_testMod.txt", header = TRUE)
activityTrain <- read.table("./train/y_trainMod.txt", header = TRUE)
activity <- rbind(activityTrain, activityTest)
combined <- cbind(activity, combined)

#save dataframe for reuse

write.csv(combined, file = "combined.csv")

#------------------------ GET TIDY DATASET ----------------------------------


#subsetMeans function subsets the combined dataset by subject (ID) and activity.
#Arguments to be passed: df = combined dataset, subjNo = subject ID, activity is the activity i.e.
#Walking (actNo = 1), WalkUpStairs (actNo = 2), WalkDownStairs (actNo = 3), Sitting (actNo = 4), 
#Standing (actNo = 5) and Laying (actNo = 6).
#The subject ID * activityNo = row number into which the returned dataframe should be placed

tidyData <- aggregate(.~ ID + Activity, data <- combined, mean, na.rm = TRUE)
tidyData <- select(tidyData, -X)
write.csv(tidyData, file = "tidyData.csv")
