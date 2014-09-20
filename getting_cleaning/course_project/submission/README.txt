README for Getting and Cleaning Data - Course Project

This README along with the "code_book.txt", "run_analysis.R", and "final_set.txt" comprise my submission for the course
project for Coursera/Johns Hopkins' "Getting and Cleaning Data" course.

CODE BOOK
The "code_book.txt" file explains all of the changes made to the original data set titled:
"Human Activity Reconition Using Smartphones Data Set" which can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

RUN ANALYSIS
The "run_analysis.R" is an r script which takes th assigned raw data set and cleans it as per the instructions for 
the course project.

FINAL SET
The "final_set.txt" document is the final output table as per the assignment specifications. Running the "run_analysis.R"
script by following the instructions below will recreate this table and write it into the working directory (with the same
"final_set.txt" title).


In order to explore the process download the dataset by using this link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

After you have dowloaded and unizpped the contents:
1) Place all of the contents into a file folder
3) Move the "run_analysis.R" script to this folder also
2) Open RStudio
3) In RStudio click "File" then "Open File..." and navigate to the folder and open "run_analysis.R"
4) Finally before running the script check the working directory using: getwd()
5) If the working directory is not the new file folder then set it to the folder using: setwd("path to the folder")
6) Highlight all the code and click "Run", this will write the tidy data set into the file folder as "final_set.txt"
as well as open the table to view in the viewing console of RStudio.




 