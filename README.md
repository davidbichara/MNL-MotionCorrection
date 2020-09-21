# MNL-MotionCorrection
Code written for Mechanical NeuroImaging Lab, Motion Correction project

Project aims to model subject movement in MRI scanner using subtraction of 3d image matrices and a gui. 

Guide to the files:

roughmovemnet.m - primitive model which attempts to model 3D image pixel displacement without adjustment for pixels lost. 

movement_detector.m - Adjusted model which compares each temporal repetition to a hypothetical 'true' image of the first repetition. Model is Adjusted for amount of pixels lost
between temporal repetitions. 

movement_detector1.m - Adjusted model which compares each temporal repetition to the repetition which occurred before it. Has volatility in estimating dynamic movement. Is adjusted
for the amount of pixels on average differing between the 3d images. 

figure_SS2020.m - Creates figures which plots two movement models which compare full temporal subtractions of the 24 temporal repetitions. 

sumstatiscs.m - Performs a series of mathematical operations on the adjusted temporal repetition subtraction data to find statistical abnormalities. The data from the set is stored
in an array and displayed to summarize the data. 

metric_gui.m - intakes data from sumstats.m to model movement in a binary fashion. Gui uses user input when model graphs have an alarming amount of area or other summary statistics
are unusual. Gui creates a point system to model movement, threshold is then created to judge if movement occurs and how much did. 

repititionslicer.m - Splits averaged 3d image into a series of 24 full temporal repetitions in the order they were taken. Creates new 3d image for each as well as accompanying
files found in folders for each repetition. Links through terminal to FSL imaging application for skull extraction from images. 






