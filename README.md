# Machine-Learning
This repo contains things I learn about machine learning 

```mermaid 
  graph TD;
  Machine-learning-algorithms--> Unsupervised-ML;
  Machine-learning-algorithms-->Reinforcements-ML;
  Unsupervised-ML--> Unlabelled_dataset;
  Unlabelled_dataset--> Clustering;
  Clustering--> Hierarchical;
  Clustering--> k-mean;
  Unlabelled_dataset-->Dimensionality_Reduction;
  Dimensionality_Reduction--> PCA;
  
  Unlabelled_dataset --> Associations;
  Machine-learning-algorithms--> Supervised-ML;
  Supervised-ML--> Labelled_datasets;

  Labelled_datasets--> Classification;
  Classification --> Random_Forest;
  Classification-->Decision_Tree;
  Classification-->Support_Vector_Machine;
  Classification-->Linear_Classifier;

  Labelled_datasets-->Regression;
  Regression-->Linear_Regression;
  Regression-->Polynomial_Regression;
  Regression-->Logistic_Regression;
  ```
**Unsupervised ML** algorithms uses unlabelled datasets to analyse and cluster the data by discovering its hidden patterns.

**Supervised ML algorithms** uses labelled datsets to train the dataset for predicting outcomes 
```mermaid
graph TD;
Supervised-ML --> Data;
Supervised-ML--> Labels;
Data-->Train_Model;
Labels-->Train_Model;
Train_Model-->Test_Data;
Test_Data-->Predict_outcome;
```
Classification assigns data into groups such as cancerous vs non cancerous while Regression allows the identificaton if the relationship between dependent and independent  variables.








