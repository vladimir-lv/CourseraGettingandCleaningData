Readme for Coursera Getting and Cleaning Data course project

Package consist of file run_analysis.R
Script read data from files located in the directory "./UCI\ HAR\ Dataset" under current working directory.
Files required for working with the script
1. Train set directory ./UCI\ HAR\ Dataset/train
  1.1 files X_train.txt, y_train.txt, subject_train.txt
2. Test set directory ./UCI\ HAR\ Dataset/test
  2.1 files X_test.txt, y_test.txt, subject_test.txt
3. File features.txt in the directory ./UCI\ HAR\ Dataset/ 

File names and case must be as noted in this file.

Script produce file subject_groups_averages.txt with final data set in the working directory.
For successful script execution dplyr package must be installed.
Script file run_analysis.R must be copied to R environment working directory.
