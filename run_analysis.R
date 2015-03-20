library(dplyr)

#define lookup dictionary for activities
activity.dict<-c(
            "Walking"=1,"Walking Up"=2,"Walking Down"=3,"Sitting"=4,"Standing"=5,"Laying"=6)

#Load of train data set from "UCI HAR Dataset/train" directory under working directory
x_train_df<-read.table("./UCI\ HAR\ Dataset/train/X_train.txt",sep = "",header=FALSE)
y_train_df<-read.table("./UCI\ HAR\ Dataset/train/y_train.txt",sep = "",header=FALSE)
subject_train_df<-read.table("./UCI\ HAR\ Dataset/train/subject_train.txt",sep = "",header=FALSE)

#Add of activity labels to activity data set
y_train_df$Activity<-names(activity.dict)[match(y_train_df$V1,activity.dict)]

#create final train data set
train_df<-cbind(subject_train_df,y_train_df$Activity,x_train_df)

#rename binded columns
names(train_df)[1]<-"Subject"
names(train_df)[2]<-"Activity"


#Load of test data set from "UCI HAR Dataset/train" directory under working directory
x_test_df<-read.table("./UCI\ HAR\ Dataset/test/X_test.txt",sep = "",header=FALSE)
y_test_df<-read.table("./UCI\ HAR\ Dataset/test/y_test.txt",sep = "",header=FALSE)
subject_test_df<-read.table("./UCI\ HAR\ Dataset/test/subject_test.txt",sep = "",header=FALSE)

#Add of activity labels to activity data set
y_test_df$Activity<-names(activity.dict)[match(y_test_df$V1,activity.dict)]

#create final test data set
test_df<-cbind(subject_test_df,y_test_df$Activity,x_test_df)

#rename binded columns
names(test_df)[1]<-"Subject"
names(test_df)[2]<-"Activity"

#merge to one data set
final_df<-rbind(train_df,test_df)
#modify subject column
final_df$Subject <-paste("Subject",final_df$Subject)

#loading of features list for mean and standart deviation
xx_features<-read.table("./UCI\ HAR\ Dataset/features.txt",sep = "",header=FALSE)
subset(xx_features,grepl("-mean",xx_features$V2,fixed = FALSE));subset(xx_features,grepl("-std",xx_features$V2,fixed = FALSE))

xx_features_names <-rbind(
                          subset(xx_features,grepl("-mean",xx_features$V2,fixed = FALSE)),
                          subset(xx_features,grepl("-std",xx_features$V2,fixed = FALSE)))

#increment fields index by 2 because of added Subject and Activity fields
xx_features_names$V1<-xx_features_names$V1+2

#generate common fields index
fields_idx<-union(c(1:2),xx_features_names$V1)

#rename columns Task #4 by removing "()" and replacing "-" to "."
xx_features_names$V2<-gsub("-",".",gsub("[()]","",xx_features_names$V2))
names(final_df)[xx_features_names$V1]<-xx_features_names$V2

#generating tidy data set
tidy_df=final_df[,fields_idx]

library(dplyr)
#tidy_df <- select(by_act_id, 1:81)
value <- names(tidy_df)[3:81]
grp_cols <- names(tidy_df[,1:2])
dots <- lapply(grp_cols, as.symbol)
subject_groups_averages_df<-tidy_df %>%
              group_by_(.dots=grp_cols) %>%
              summarise_each(funs(mean))

write.table(subject_groups_averages_df,file="subject_groups_averages.txt", row.name=FALSE)

