# CodeBook
## Introduction
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

## Methods
(1) Steps to get the final **tidy_data.txt**
 - Merge the data from set/train set by attaching the set data after train data respectively
 - Relabel the columns and extract the columns with "mean" and "std"
 - Change the number 1-6 in *activity* column into corresponding descriptive labels (e.g. walking)
 - Change the column label into descriptive and readable labes (e.g. f --> frequency)
 - Calculate the mean of each column in terms of different subjects and activities, getting a 30*6 = 180 rows table, i.e. the final result

(2) Variable

|variable|description|
---------|------------
|***activities***|the activites participants take: walking, walking upstairs, walking downstairs, sitting, standing, laying|
|***subjects***|the participant id: 1-30|
|*others*|***time***: quantified by time <br /> ***frequency***: quantified by frequency <br /> ***body***: parameters from body measurement <br /> ***gravity***: parameters from gravity measurement <br /> ***acceleration***: linear acceleration <br /> ***gyroscope***: angular velocity <br /> ***jerk***: Jerk signals <br /> ***magnitude***: magnitude of signals calculated using the Euclidean norm <br /> ***mean***: data presented as mean  <br /> ***std***: data presented as standard deviation  <br /> ***x/y/z***: the x/y/z axial signals  <br /> e.g. <br />  `time_gravity_acceleration_mean_x: mean time of acceleration of gravity for x axis ` <br /> `frequency_body_gyroscope_magnitude_mean: mean frequency of magnitude of body gyroscope`  <br />  `frequency_body_acceleration_jerk_magnitude_std: standard deviation of frequency of body acceleration jerk magnitude` <br /> |

## Citation
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
