The run_analysis.R script assumes that the data is in a folder with the following structure:

- UCI HAR Dataset
	- activity_labels.txt
	- features_info.txt
	- features.txt
	- test
		- subject_test.txt
		- X_test.txt
		- y_test.txt
	- train
		- subject_train.txt
		- X_train.txt
		- y_train.txt

Also, it requires write access, so it can write the tidy_data.txt file.

Basically, it executes the following steps:

1. Loads data.table package, instaling it if needed;
2. Loads reshape2 package, instaling it if needed;
3. Loads the activity labels;
4. Loads the features names;
5. Determines the features of interest (mean and standard);
6. Load, subset and structure the test data;
7. Load, subset and structure the train data;
8. Merges the training and test data;
9. Modify some values to make it more readable;
10. Structure the tidy data;
10. Writes the tidy data file.
