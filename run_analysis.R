testdata <- read.table("X_test.txt")
testlabels <- read.table("y_test.txt")
testsubjects <- read.table("subject_test.txt")
traindata <- read.table("X_train.txt")
trainlabels <- read.table("y_train.txt")
trainsubjects <- read.table("subject_train.txt")
features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")
data <- rbind(testdata, traindata)
labels <- rbind(testlabels, trainlabels)
subjects <- rbind(testsubjects, trainsubjects)
colnames(data) <- features[,2]
tomatch <- c("mean()", "std()")
data <- data[,grep(paste(tomatch, collapse="|"), names(data), value=TRUE)]
data <- data[,grep("Freq", names(data), value=TRUE, invert=TRUE)]
names(data) <- tolower(names(data))
data <- cbind(data, labels)
names(data)[67] <- "activity"
data$activity <- factor(data$activity)
levels(data$activity) <- activities[,2]
data <- cbind(data, subjects)
names(data)[68] <- "subject"
names(data) <- sub("tbodyacc", "timebodyacceleration", names(data),)
names(data) <- sub("tgravityacc", "timegravityacceleration", names(data),)
names(data) <- sub("tbodygyro", "timebodyangularvelocity", names(data),)
names(data) <- sub("fbodyacc", "frequencybodyacceleration", names(data),)
names(data) <- sub("fbodybodyacc", "frequencybodyacceleration", names(data),)
names(data) <- sub("fbodygyro", "frequencybodyangularvelocity", names(data),)
names(data) <- sub("fbodybodygyro", "frequencybodyangularvelocity", names(data),)
data <- suppressWarnings(aggregate(data, list(data$activity, data$subject), mean))
write.table(data, file = "output.txt", row.names = FALSE)