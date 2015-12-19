# Activity-Classification-UCI-HAR-Dataset-
Activity Classification using smartphone(UCI HAR Dataset)

In this UCI HAR DATASET is used which get it from 30 subject doing 6 activity.

These activity are -

1. WALKING

2. WALKING_UPSTAIRS

3. WALKING_DOWNSTAIRS

4. SITTING

5. STANDING

6. LAYING



##Prerequisites-

1) R Framework

2) dplyr library


To train and test the model use ==> modeling_action.R

To test the activity ==> source("testing.R")
                         
                         action_test(inputdata,model_path)
                         
                         where inputdata -->activity feature vector  
                               model_path --> train model ( which save on cluster_action repo, use cluster_3)
