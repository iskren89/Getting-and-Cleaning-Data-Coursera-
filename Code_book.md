---
title: "Code_Book"
author: "iskren89"
date: "6/7/2020"
output: html_document
---
Steps taken to go from raw data to the final result:
1) Downloaded and extracted the zip file:
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]
2) Loaded and merged all .txt files from test and train folders to a new data set called "all_data"
3) Used the activity_labels.txt and features.txt files to label the data with descriptive names
4) Subsetted the "all_data" dataset to a new dataset called "tidy" keeping the feature columns on 'mean' and 'std' and removing the other feature columns
5) Merged the "tidy" with the dataset on activities in a new dataset "tidier" in order to have descriptive activity names in the final result
6) Created a new "tidy_data" dataset with the average of each variable for each activity and each subject.

The final result is a "tidy_data" dataset containing the following variables (columns):
1) Activity_Name: with labels for the 6 activities performed in the experiment (integer from 1 to 6)
2) Volunteer: with the volunteer numbers of the 30 people in the experiment (integer from 1 to 30)
3) to 68) The average value of each 'mean' and 'std' feature (number from -1 to 1)
