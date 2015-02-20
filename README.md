# getting_cleaning_data_course_project

This repository contains the following files:
- run_analysis.R
- CodeBook.md
- README.md

## run_analysis.R
Script that reads in Data from directory "UCI HAR Dataset" (The data directory and the run_analysis.R script do have to be the same directory). There are three text files for the trainign data and three for the test data that are joined to one big data set first using cbind (to bind the contents of the three text files of each type) and then using rbind (to bind the resulting data set for the two types of data). The script also reads in the column names from features.txt and binds them to the columns. It then filters only the relevant columns that cointain data for mean and standard deviation and changes the numbers indicating the activity names into the names itself. In a last step a new data set is created that contains only the average values for each subject and activity. That data set is returned in the end.

## CodeBook.md
Describes the variables used in the data set returned by run_analysis.R
