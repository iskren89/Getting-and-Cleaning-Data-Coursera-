# Loading the required libraries
library(dplyr)
library(data.table)
library(reshape2)
library(stringr)
# Loading the raw data files
subject_test<-read.table("/home/iskren/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
x_test<-read.table("/home/iskren/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("/home/iskren/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_train<-read.table("/home/iskren/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
x_train<-read.table("/home/iskren/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("/home/iskren/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
activities<-read.table("/home/iskren/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
features<-read.table("/home/iskren/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")[,2]
# 3.) Uses descriptive activity names to name the activities in the data set
names(activities)<-c("Activity_ID","Activity_Name")
subject_test<-rename(subject_test, Volunteer = V1)
y_test<-rename(y_test, Activity = V1)
subject_train<-rename(subject_train, Volunteer = V1)
y_train<-rename(y_train, Activity = V1)
# 4.) Appropriately labels the data set with descriptive variable names. 
names(x_test)<-features
names(x_train)<-features
# 1.) Merges the training and the test sets to create one data set:
all_test<-cbind(subject_test,y_test,x_test)
all_train<-cbind(subject_train,y_train,x_train)
all_data<-rbind(all_test,all_train)
# 2.) Extracts only the measurements on the mean and standard deviation
# for each measurement.
tidy<-all_data[,(grepl("Volunteer|Activity|mean()|std()",names(all_data)))&!grepl("meanFreq",names(all_data))]
# Merge and prepare the initial data set for the final step that 
# creates the new summary data set
tidier<-merge(activities,tidy,by.x = "Activity_ID",by.y="Activity")
tidier$Activity_ID<-as.numeric(tidier$Activity_ID)
tidier$Volunteer<-as.numeric(tidier$Volunteer)
tidier<-arrange(tidier,Volunteer,Activity_ID)
# 5.) From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.
grouped<-group_by(tidier,Activity_Name,Volunteer)
result<-summarize_all(grouped,mean)
tidy_data<-select(result,-(Activity_ID))
tidy_data[,3:ncol(tidy_data)]<-round(tidy_data[,3:ncol(tidy_data)],6)
View(tidy_data)
write.csv(tidy_data,"tidy_data.csv")