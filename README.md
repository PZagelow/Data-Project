# Data-Project
Getting and Cleaning Data Course Project

The data is assumed to have been downloaded to the working directory from this URL
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This project contains code to:
<ul>
<li>Merge the training and the test sets to create one data set.
<li>Modify the activity number to name the activities in the data set
<li>Modify the column names to use descriptive variable names. 
<li>Extract only the measurements containing the strings 'mean' and 'std'
<li>Creates a tidy data set with the average of each remaining variable for each activity and each subject.
<li>Writes the data frame to a table called tidySet.txt
<eul>

This project requires the following packages be installed:  plyr, dpylr.
