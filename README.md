# Machine-Learning-Species-Distribution-Modeling_Tuna-CPUE-DATA
# Workflow - Roadmap
# 1
Data Collection and Pre-processing: This project utilizes the TUNA fisheries dataset (location, date and time, amount, KG per long line fishing operation) in the regions of the Arabian Sea and Bay of Bengal that included; CPUE is calculated per amount of fish per 100 hooks. These were studied by influencing environmental parameters in a multi-step process: The fisheries data was collected and compiled and constituted productivity measurements (e.g., catch data), presence and absence records of different fish species, time series data for productivity and environmental parameters, and environmental parameters (e.g., water temperature, salinity, depth, etc.)
# 2
Data Cleaning and Exploration: Handled missing data by imputing or removing it and explored the data to understand its distribution, correlations, and potential outliers.
Matching fisheries data with environmental variables.
CMEMS data ( sst, ssh, mld, eke, zsd, sss…) and Globcolour (hermis.acri.fr) data (chl, secchi depth) of 0.25-degree resolution daily mean data were extracted and matched with gridded fisheries data using R.
# 3
Data Splitting: The data was split into training, validation, and test sets. The validation set will be used for hyperparameter tuning.
# 4
Model Selection: The models utilized included; Random Forest – since it is a suitable choice for this type of data as it has mixed categorical and continuous features. BRT, GAMS, and BLM
# 5
Hyperparameter Tuning: The validation set was used to tune the hyperparameters of the Random Forest model. Common hyperparameters include the number of trees, maximum depth of trees, and minimum samples per leaf.
# 6
Model Training: The Random Forest model was trained on the training data using the tuned hyperparameters.
# 7
Model Evaluation: The performance of each model (e.g. Random Forest) was evaluated on the validation set using appropriate metrics for your specific problem (e.g., accuracy, F1-score, ROC AUC, etc.).
# 8
Fine-Tuning: We considered further hyperparameter tuning or feature selection/engineering where the model/s the model performance was not satisfactory.
# 9
Testing: After achieving a satisfactory model on the validation set, its performance was evaluated on the test set to ensure it generalizes well to new, unseen data.
# 10
Interpretability: Random Forest models, for instance, offer feature importance scores. We used these to interpret which environmental parameters are most influential in predicting fishery productivity or species presence/absence.
# 11
Deployment and Monitoring: We then determined if the model/s is successful using the root mean square error (RMSE). We intend to deploy the working model/s in a real-world setting to make predictions. Also, we intend to monitor its performance over time and retrain if necessary as new data becomes available.
# 12
Documentation and Reporting: We intend to document the entire process, including data pre-processing steps, model architecture, hyperparameter choices, and evaluation metrics, and thereafter report any insights gained.
# 13
Continuous Improvement: We intend to continue collecting data and refine the model as more data becomes available. This iterative process can lead to improved model performance over time. Note: The success of machine learning models depends on the quality and quantity of the data, as well as the domain knowledge one applies during the feature engineering and interpretation of the results. Additionally, in this project, we consider other machine learning techniques in comparison to choose the best if one model does not provide satisfactory results.
