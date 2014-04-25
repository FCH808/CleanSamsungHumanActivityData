Codebook
========

This document describes the steps involved in cleaning the data as described in readme.md


RAW DATA
--------
**All the files contain data in space-separated-values format**

**None of the files contain column names or row names**

### Common Files
* ***features.txt:*** **(dimesions:561,2):** Contains the IDs and names of the variables

* ***activity_labels.txt:*** **(dimesions:6,2):** Contains the IDs and names of the activities

### Training data files
* ***train/X_train.txt:*** **(dimesions:7352,561):** Contains the values of all the variables in each observation of the training experiments set

* ***train/y_train.txt:*** **(dimesions:7352,1):** Contains the activity ID of each observation/row in the observations file ***(train/X_train.txt)***

* ***train/subject_train.txt:*** **(dimesions:7352,1):** Contains the participant ID of each observation/row in the observations file ***(train/X_train.txt)***



### Testing data files
* ***test/X_test.txt:*** **(dimesions:7352,561):** Contains the values of all the variables in each observation of the testing experiments set

* ***test/y_test.txt:*** **(dimesions:7352,1):** Contains the activity ID of each observation/row in the observations file ***(test/X_test.txt)***

* ***test/subject_test.txt:*** **(dimesions:7352,1):** Contains the participant ID of each observation/row in the observations file ***(test/X_test.txt)***

STEP 1: Creating first data set
-------------------------------


1. Check whether the ***UCI HAR Dataset*** folder exists in the current directory. If not, download and unzip it

2. Load the files ***train/X_train.txt, train/y_train.txt, train/subject_train.txt, test/X_test.txt, test/y_test.txt, test/subject_test.txt and activity_labels.txt*** into respective variables

3. Bind the columns of `subject_test, y_test` and `x_test`, to form a testing dataframe

4. Bind the columns of `subject_train, y_train` and `x_train` to form a training dataframe

5. Bind the rows of the two data frames obained in the 2 previous steps (3 and 4), to obtain `big_DF`

6. Set the column names of `big_DF` to "subject" then "activity" then the values read from ***features.txt***

STEP 2: Extracting the mean and standard deviation of each measurment
---------------------------------------------------------------------

1. Use `grep()` to find the column names that match "subject", "activity" or contain "mean()" or "std()"

2. Assign to `big_DF` a dataframe that only contains the columns from big_DF that we obtained from the previous step.


STEP 3-4: Labeling the data set with descriptive activity names
---------------------------------------------------------------
1. Match the keys from the `activities` dataframe to the activity values in `big_DF` and replace them with the corresponding names from the `activities` DF.

STEP 5: Creating a new, tidy data set with the average of each variable for each activity and each subject
----------------------------------------------------------------------------------------------------------
1. Use the `melt()` function to reshape `big_DF` into a 4-column dataframe that contains the columns "activity", "subject", "variable" and "value". *(The `id.vars` used are "activity" and "subject")*

2. Use the `dcast()` function to cast the previously molten dataframe while applying the `mean` aggregate function in order to collapse the rows that have a commmon subject and activity while applying the `mean` function to the values

3. Assign the obtained data.frame to a variable called `clean_DF` in the calling environment
