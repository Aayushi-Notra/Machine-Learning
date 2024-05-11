#Comparing results from DT, RF and SVM on the same dataset 

#Loading the libraries 
library(ggplot2)
library(dplyr)
library(tidyverse)
library(rpart) #DT
library(caret)
library(randomForest)
library(e1071) #SVM

#working on R in-built data 
View(iris)
unique(iris$Species)

#Generating the train and  test set 
nrows_i <- nrow(iris)
train <- sample(nrows_i, 0.7*nrows_i)
test <- nrows_i %>% seq_len() %>% setdiff(train)

train_data <- iris[train, ]
test_data <- iris[test, ]

table(train_data$Species)

#output:    setosa versicolor  virginica 
#            37         36         32 
#in this data we have three classes which means it is multicladdification problem

#The classes that we want to classify at the end of our analysis should be comparable 
#eg: the difference between the values should not have a huge difference 

#in those cases we can perform data agumentation 
#or we can cut down the data to make the values comparable 

#lets make a model  
model_tree <- rpart(Species~., data = train_data, method = 'class')
preticed_species <- predict(model_tree,test_data)

#having a look at the data 
preticed_species
#if we mention type in predict function we get the class instead of a number
predicted_species <- predict(model_tree,test_data,type = 'class')
predicted_species

observed_species <- test_data$Species

#creating a confusion matrix 
confusionMatrix(predicted_species, observed_species)

#4 versicolor species were missclassified using DT 

#using random forest for classification 
model_rf <- randomForest(Species~.,train_data)
prediction_rf <- predict(model_rf,test_data)
table(prediction_rf,observed_species)
#3 versicolor species were missclassifed


#Support Vector Machine 

model_svm <- svm(Species~.,data = train_data)
prediction_svm <- predict(model_svm,test_data)
table(prediction_svm, observed_species)
#SVM classifies all the three species correctly 

#Creating a dataframe
df_prediction = data.frame('Observed'=observed_species,
                           'Predicted_DT'=predicted_species,
                           'Predicted_RF'=prediction_rf,
                           'Predicted_SVM'=prediction_svm)

#Datapoints 53,71,73,77 were not classified correctly for RF & DT

#Unsupervised 
#clustering libraries 
library(ggpubr)
library(factoextra)


Mean_new_df <- data.frame(iris)
Mean_new_df$Species <- NULL

#Converting the dataframe into a matrix 
Mean_new_df <- as.matrix(Mean_new_df)

#lets perform K-mean clustering with k=3 
res.km <- kmeans(scale(Mean_new_df), centers = 3)
res.km$cluster

#plotting the clusters 
plot = fviz_cluster(res.km, data= Mean_new_df, 
                    geom = c('point'), repel = F,
                    ellipse.type = 'convex',
                    labelsize = 15)


plot





