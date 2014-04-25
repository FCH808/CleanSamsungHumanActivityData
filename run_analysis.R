
cleanSamsungData <- function(){
     library(reshape2)
     
     if(!file.exists('./UCI HAR Dataset')){
          message("Dataset folder not present in the working directory.\nDownloading Dataset...")
          url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
          download.file(url, "samsung.zip", method=ifelse(.Platform$OS.type=="windows", "internal", "curl"))
          unzip("samsungdata.zip")
     }
     
     
     message("Reading Data..")
     
     # Loading test DFs
     subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", sep="")
     y_test <- read.table("UCI HAR Dataset/test/y_test.txt", sep="")
     x_test <- read.table("UCI HAR Dataset/test/X_test.txt", sep="")
     
     # Loading train DFs
     subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", sep="")
     y_train <- read.table("UCI HAR Dataset/train/y_train.txt", sep="")
     x_train <- read.table("UCI HAR Dataset/train/X_train.txt", sep="")
     
     # Load activity labels
     activities <- read.table("data/activity_labels.txt", sep="", col.names=c("key", "name"))
     
     message("Merging data")
     test_DF <- cbind(subject_test, y_test, x_test)
     train_DF <- cbind(subject_train, y_train, x_train)
     big_DF <- rbind(test_DF, train_DF)
     
     # Change column names to indicative name
     features <- read.table("data/features.txt", sep="")
     features <- c("subject", "activity", as.vector(features$V2))
     colnames(big_DF) <- features
     
     #step 2
     message("Extracting mean and standard deviation measurments")
     columnsToKeep <- colnames(big_DF)[grepl("subject|activity|mean\\(\\)+|std\\(\\)+", colnames(big_DF), perl=TRUE)]
     big_DF <- big_DF[,columnsToKeep]
     
     #step 3/4 Replace activity numbers by descriptive activity names
     message("Naming activities")
     big_DF[["activity"]] <- activities[match(big_DF[['activity']], activities[["key"]]), "name"]
     
     # DOUBLE CHECK ME
     # Step 5: Creating ndependent tidy data set with the average of each 
     #         variable for each activity and each subject. 
     message("Generating clean data set")
     melted <- melt(big_DF, id.vars=c("activity","subject"))
     clean_DF <<- dcast(melted, activity + subject ~ variable, mean)
      
     message("\nDone generating dataset. (dataset located in the variable <clean_DF >)")
}  

message("File loaded. To generate the clean dataset call the function cleanSamsungData()")