if (!require("data.table")) {
  install.packages("data.table")
  require("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
  require("reshape2")
}

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
extract_features <- grepl("mean|std", features)

loadAndProcessData <- function(xPath, yPath, subjectPath) {
	xData <- read.table(xPath)
	yData <- read.table(yPath)
	subjectData <- read.table(subjectPath)

	names(xData) = features

	## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
	xData = xData[,extract_features]

	yData[,2] = activity_labels[yData[,1]]
	names(yData) = c("Activity_ID", "Activity_Label")
	names(subjectData) = "subject"

	cbind(as.data.table(subjectData), yData, xData)
}

testData <- loadAndProcessData("./UCI HAR Dataset/test/X_test.txt", "./UCI HAR Dataset/test/y_test.txt", "./UCI HAR Dataset/test/subject_test.txt")
trainData <- loadAndProcessData("./UCI HAR Dataset/train/X_train.txt", "./UCI HAR Dataset/train/y_train.txt", "./UCI HAR Dataset/train/subject_train.txt")

## 1. Merges the training and the test sets to create one data set.
data = rbind(testData, trainData)

## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
idLabels = c("subject", "Activity_ID", "Activity_Label")
dataLabels = setdiff(colnames(data), idLabels)
meltData = melt(data, id = idLabels, measure.vars = dataLabels)

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_data, row.name=FALSE, file = "./tidy_data.txt")
