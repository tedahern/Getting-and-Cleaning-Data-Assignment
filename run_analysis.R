# Read data files

testdata <- read.table("X_test.txt")
testlabels <- read.table("y_test.txt")
testsubjects <- read.table("subject_test.txt")
traindata <- read.table("X_train.txt")
trainlabels <- read.table("y_train.txt")
trainsubjects <- read.table("subject_train.txt")
features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

#Combine test and train data

data <- rbind(testdata, traindata)
labels <- rbind(testlabels, trainlabels)
subjects <- rbind(testsubjects, trainsubjects)

#Name the variables

colnames(data) <- features[,2]

#Extract only the mean and standard deviation measurements

tomatch <- c("mean()", "std()")
data <- data[,grep(paste(tomatch, collapse="|"), names(data), value=TRUE)]
data <- data[,grep("Freq", names(data), value=TRUE, invert=TRUE)]

#Make the variable names more tidy by making them lowercase

names(data) <- tolower(names(data))

#Adding factor variables to link activities and subjects to each measurement

data <- cbind(data, labels)
names(data)[67] <- "activity"
data$activity <- factor(data$activity)
levels(data$activity) <- activities[,2]
data <- cbind(data, subjects)
names(data)[68] <- "subject"
data$subject <- factor(data$subject)

#Further improving the names of the variables by making the names more descriptive

names(data) <- sub("tbodyacc", "timebodyacceleration", names(data),)
names(data) <- sub("tgravityacc", "timegravityacceleration", names(data),)
names(data) <- sub("tbodygyro", "timebodyangularvelocity", names(data),)
names(data) <- sub("fbodyacc", "frequencybodyacceleration", names(data),)
names(data) <- sub("fbodybodyacc", "frequencybodyacceleration", names(data),)
names(data) <- sub("fbodygyro", "frequencybodyangularvelocity", names(data),)
names(data) <- sub("fbodybodygyro", "frequencybodyangularvelocity", names(data),)

#Extracting the means of each measurement for each activity and subject

data <- aggregate(.~subject+activity, FUN=mean, data=data)

#Sending output to a text file

write.table(data, file = "output.txt", row.names = FALSE)