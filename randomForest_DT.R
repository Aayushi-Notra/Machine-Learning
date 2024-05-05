 #Using Random forest Model 

#installing package and loading libraries 
install.packages("randomForest")
library(randomForest)
library(dplyr)
library(ggplot2)

#Regression using random forest


#Loading in the covid dataset 
covid_data <- read.csv("C:/Users/notay003/Downloads/r_data/owid-covid-data.csv")

#Subsetting the dataset to contain just two continents 
covid_data <- covid_data[covid_data$continent %in% c("Asia" ,"Europe","North America", "Africa","South America"),  ]
#filtering in the columns of interest 
covid_data <- covid_data[,c(2,3,8,18,20,32,35,36,37,45,48,49,52,53)]
#removing empty rows 
covid_data <- na.omit(covid_data)
rownames(covid_data) <- 1:nrow(covid_data)
#After removing empty rows the dataframe has data for 3 continents 
#"Aisa","North America" and Europe 

#Dividing the dataset into train and test sets 
nrows <- nrow(covid_data)
train <- sample(nrows, 0.7*nrows)
test <- nrows %>% seq_len() %>% setdiff(train)

covid_train <- covid_data[train,]
covid_test <- covid_data[test,]

#The accuracy of Random forest depends upon the number of trees
RF_model = randomForest(total_deaths ~icu_patients+hosp_patients+
                        positive_rate+people_fully_vaccinated,data=covid_train)

summary(RF_model)

#training the model
predicted_death <- predict(RF_model,covid_test)
covid_test$predicted_death <- predicted_death

total_death <- covid_test$total_deaths

#looking _at the correlation between the original and predicted 
cor(predicted_death,total_death)

#making a plot
ggplot(covid_test, aes(x=predicted_death,y=total_deaths))+
  geom_point()

#As compared to a simple linear regression model that we generated using the lm()
#linear regression performed with random forest is more comprehensive 
#the correlation coefficient has improved

#Using Decision Tree for classification
library(rpart)
library(caret)
DT_model <- rpart(continent~icu_patients+hosp_patients+
        positive_rate+people_fully_vaccinated,data=covid_train,method='class')

predicted_conti <- predict(DT_model,covid_test)
original_conti <- covid_test$continent

#converting the dataframe: predicted_conti to a vector 

new_predicted <- character(865)

# Loop through each row of the predicted continent matrix
for (i in 1:865) {
  # Check if the value in the first column indicates Asia
  if (predicted_conti[i, 1] == 1) {
    new_predicted[i] <- 'Asia'
  } else if (predicted_conti[i, 2] == 1) {  # Check if the value in the second column indicates Europe
    new_predicted[i] <- "Europe"
  } else {  # If neither Asia nor Europe, assume it's North America
    new_predicted[i] <- "North America"
  }
}

#converting vector into factors 
new_predicted_factor <- factor(new_predicted, levels = c("Asia", "Europe", "North America"))
original_conti_factor <- factor(original_conti, levels = c("Asia", "Europe", "North America"))


confusionMatrix(new_predicted_factor,original_conti_factor)

#------------------------------------------------------------

#Results 

#The confusion matrix is a table that describes the performance of a classification model on a set of test data.
#It shows the counts of true positive (correctly predicted), true negative (correctly rejected), false positive (incorrectly predicted as positive), and false negative (incorrectly predicted as negative) predictions.



#confusionMatrix(new_predicted_factor,original_conti_factor)
#Confusion Matrix and Statistics

#Reference
#Prediction      Asia Europe North America
#Asia            55      0             0
#Europe           0    508             0
#North America   10    178           114

#Overall Statistics

#Accuracy : 0.7827        :Tells about the Proportion of correct predictions.  
#95% CI : (0.7537, 0.8097) :95% Confidence Interval for the accuracy
#No Information Rate : 0.7931          
#P-Value [Acc > NIR] : 0.7882          

#Kappa : 0.5504  :Cohen's Kappa statistic, which measures the agreement between the observed accuracy and the expected accuracy.        

#Mcnemar's Test P-Value : NA : assesses the difference between predicted and observed classifications.              

#Statistics by Class:

 #                    Class: Asia Class: Europe
#Sensitivity              0.84615        0.7405 :The proportion of actual positives correctly identified.
#Specificity              1.00000        1.0000 :The proportion of actual negatives correctly identified. 
#Pos Pred Value           1.00000        1.0000 :Precision 
#Neg Pred Value           0.98765        0.5014
#Prevalence               0.07514        0.7931
#Detection Rate           0.06358        0.5873
#Detection Prevalence     0.06358        0.5873
#Balanced Accuracy        0.92308        0.8703
#                     Class: North America
#Sensitivity                        1.0000
#Specificity                        0.7497
#Pos Pred Value                     0.3775
#Neg Pred Value                     1.0000
#Prevalence                         0.1318
#Detection Rate                     0.1318
#Detection Prevalence               0.3491
#Balanced Accuracy                  0.8748


#Based on the values of the confusion matrix the model seems to be not great but reasonable 




