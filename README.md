##Getting and Cleaning Data Assignment

###How my Script Works

My first eight lines are read.table commands, and are there to read in the various data that will eventually be pieced together into a tidy data set.

The next three lines are rbind commands. This is where I start to piece some of the data together. Basically, what I am doing here is combining the test and training data. Initially, the test and training data were broken down into 2 separate sets of files - a test and a training set. Each of these sets had separate files to record the observations, the associated activities, and the associated subjects. The rbind commands combine the test and training data, so that now there is one set of observations, one set of associated activities, and one set of associated subjects.

Next, I begin to make the data tidy through several steps, beginning with giving the variables meaningful names by renaming the columns of my data frame with names that come from the features.txt file that was supplied with the data. While these names are an improvement, I will be further refining them in a later step.

The following three lines of code are included to meet the requirement to extract the measurements on the mean and standard deviation for each measurement. Notice that I've chosen to exclude the meanFreq() observations, as these are described in the features.txt file as "Weighted average of the frequency components to obtain a mean frequency", as opposed to a true mean value.

Next, I continue to tidy up the variable names by converting them to all lowercase, per the course lecture recommendations.

In the next six lines, I use cbind commands to add the information about the specific activities and subjects associated with each measurement, and name the new variables accordingly. Also note that I make the activity variable a factor variable, and then replace the numeric values with descriptive ones, fulfilling requirement 3 of the assignment.

The next seven lines of code are there to rename the variable names again, this time replacing the shortened descriptions obtained from the features.txt file with ones that are more easily readable. Per course lecture, readable variable names are a principle of tidy data; I looked to the features_info.txt for more complete descriptions of the variables.

Lastly, I fulfill the final requirement of the assignment by creating a tidy data set with the average of each variable for each subject and activity.