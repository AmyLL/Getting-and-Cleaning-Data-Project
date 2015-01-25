##README

The run_analysis.R code implements code (R version 3.1.2) to generate a tidy data set from the training and test datasets in the UCI HAR Dataset (see Ref. 1):

	Human Activity Recognition Using Smartphones Dataset
	Version 1.0
	Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
	Smartlab - Non Linear Complex Systems Laboratory
	DITEN - Università degli Studi di Genova.
	Via Opera Pia 11A, I-16145, Genoa, Italy.
	activityrecognition@smartlab.ws
	www.smartlab.ws

To run the code without changing filepaths within the code, place the code in the UCI HAR Dataset folder.

The data represents 561 variables measured on 30 individuals collected from the accelerometers and gyroscopes in their smartphones while performing the following 6 activities: walking, walking upstairs, walking downstairs, sitting, standing and laying.

The list of the 561 variables measured is found in the features.txt files within the dataset folder. The activity labels are found in the activity_labels folder within the dataset folder.

Also within the UCI HAR Dataset folder are two subfolders,"test" and "train" containing the data from the test cases and the training cases. Specifically, for this project, X_test and X_train data were of interest. The inertial data files were not uses. Within the "test" and "train" folders, the "subject_test" or "subject_train" files contain a list of the subjects associated with each row in the X_ test or X_train datasets. Additionally, the "Y_test" files within the folders represent the activity associated with each measurement.
For each record it is provided:

The scope of this project involved calculating the mean measurement of each subject performing each activity. The data of interest were all measurements that were either a previously calculated mean measurement or the standard deviation of the measurement. Thus only a subset of the original dataset is required for the analysis.

1. The first step in generating the tidy dataset involved using a text editor on the features.txt file supplied to remove all punctuation (commas, parentheses and dashes) within the variables to allow for use of the variable names within R. Capital letters were introduced to separate individual words within the names as opposed to spaces. This was performed using Microsoft Word and the file saved as "featuresMod.txt" for use in subsetting out the required measurements.

2. The subject index for both the test and train datasets was read and stored in R as either "idTest" or "idTrain" and given the column name "ID" to represent the subject ID.

3. The activity data provided was a list of numbers identifying the activities with a number code from 1 to 6. These files ("y_Test" and "Y_train" were modified within a text editor (Microsoft Word) and given appropriate activity names as follows:
	1. Walking	2. WalkUpStairs		3. WalkDownStairs
	4. Sitting	5. Standing		6. Laying
The file was saved as "y _test/trainMod.txt and this file was used to attach the proper activity codes to the measurement data.

4. Since only a small subset of the features were required, after the featuresMod.txt file was read into R (V3.1.2) as the "features" table, a new column was appended "colOfInt" and given the value of TRUE if the variable name contained either "mean" or "std" since these are the variables of interest for this project. The subset in which the "colOfInt" is TRUE represents the subset required for this assignment ("reqFeatures). This subset contains the column numbers from the test and train measurements that need to be analyzed.

5. Originally, the X_test and X_train data files were read in using the subsetting during the read.csv step. This did not provide for reproducible input, so the code is set to read in the entire datasets then subsequently subsetting based on the columns providing means and std. (Not the most efficient and should work on that...)

6. After generating the required test and train subsets, the column names of the data set were given the names from the "reqFeatures" table by transposing the column of the dataset that contains the names. The datasets were then ready to have the subject IDs and the activity labels attached to the beginning of either the test or train subset. The two subsets are then ready to be merged with all columns in both subsets containing equivalent and appropriate column names.

7. To get the data into a more compact form, the data was first grouped by Subject ID then acitivity, and the means of the data from each group were calculated. This was performed using the aggregate() function. The tidy dataset was written and saved as "tidyData.csv".

RESULTS:

The tidy data set included 86 variables from the original 561. The combined dataset (test + train data) contained 10,299 observations. Summarizing by Subject and Activity reduced this to 180 final results.

NOTE:

Since the original measurements were normalized to and bounded to [-1, 1], the mean of the the measurements should also fall within this range.


This submission contains the following files:

- 'README.txt'

- 'CODEBOOK.txt'

- 'run_analysis.R': R code for generating the tidy dataset

- 'tidyData.csv': output from R code above

- 'featuresMod.txt': List of all variables used in the analysis (column names).

- 'y_trainMod.txt' and 'y_testMod': the activity indices for the train and test data 

UCI HAR Dataset Reference:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
