# load required library
library(plyr)
library(dplyr)

# read in data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

# read in features
feats <- read.table("./UCI HAR Dataset/features.txt")

#set column names from features for x data sets
colnames(X_train) <- feats[,2]
colnames(X_test)  <- feats[,2]

#select only the columns with names containing mean or std,
# first must remove duplicate column names to use matches() 
X_train <- X_train[,!duplicated(colnames(X_train))]
X_test  <- X_test[,!duplicated(colnames(X_test))]
X_train <- select(X_train,matches("mean|std"))
X_test  <- select(X_test,matches("mean|std"))

#give both y data frames a descriptive column name
colnames(y_train) <- "activity_num"
colnames(y_test) <- "activity_num"

#give both subject data frames a descriptive column name
colnames(subj_train) <- "subject"
colnames(subj_test) <- "subject"

# make both train and test sets wide by including columns from all
merged_train <- cbind(subj_train,y_train,X_train)
merged_test  <- cbind(subj_test,y_test,X_test)
  
# merge test and training data to make one long data set with all rows
mergedAll <- rbind(merged_train,merged_test)

#create a tidy data set with the average of each variable for each activity and each subject.
tidySet <- ddply(mergedAll,.(subject,activity_num),colMeans)

# read in activity_labels 
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(activities) <- c("activity_num","activity")

#add a new column with the activity names using the activity num
tidySet <- left_join(tidySet,activities,by="activity_num")

#remove the activity_num column and reorder the columns
tidySet <- select(tidySet,-activity_num)
tidySet <- select(tidySet,subject,activity,everything())

#write out the resulting data set
write.table(tidySet,file="tidySet.txt",row.names=FALSE)
