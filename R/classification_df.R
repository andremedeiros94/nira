#' @title classification_df
#' @description Function to develop classification models
#' @param df data frame with the last column corresponding to the class or group being used.
#' @param splitting Establishes the proportion and creates divisions balanced the training data and test.
#' @param algorithm Algorithm that will be used to create the models.
#' @param method_cv The resampling method: "boot", "boot632", "optimism_boot", "boot_all", "cv", "repeatedcv", "LOOCV", "LGOCV"
#' @param number_cv Either the number of folds or number of resampling iterations
#' @param repeat_cv For repeated k-fold cross-validation only: the number of complete sets of folds to compute
#' @usage classification_df(df)
#' @import caret
#' @import e1071
#' @examples
#' data(nir_seed)
#' dados<-classification_df(nir_seed)
#' @export

classification_df<-function(df,splitting=0.7,algorithm="kernelpls",method_cv="repeatedcv",number_cv = 10,repeats_cv=3){
  
  set.seed(7)
  trainIndex <- createDataPartition(df[,length(df)], p = splitting, 
                                    list = FALSE, 
                                    times = 1)
  
  base_treinamento <- df[trainIndex,]
  base_teste<- df[-trainIndex,]
  
  set.seed(7)
  fitControl <- trainControl(
    method = method_cv,
    number = number_cv,
    ## repeated ten times
    repeats = repeats_cv)
  
  
  model = train(base_treinamento[,-length(df)],
                base_treinamento[,length(df)],
                method = algorithm,
                tuneLength = 10,
                trControl = fitControl);
  
  save(model, file="model.Rdata")
  a<-model
  
  
  
  previsoes = predict(model , newdata = base_treinamento[,-length(df)])
  matriz_confusao = table(previsoes, base_treinamento[,length(df)])
  results_training<-confusionMatrix(matriz_confusao)
  b<-results_training
  
  previsoes = predict(model, newdata = base_teste[,-length(df)])
  matriz_confusao = table(previsoes,base_teste[, length(df)])
  results_test<-confusionMatrix(matriz_confusao)
  c<-results_test
  
  mylist<-list("Cross-validation"=a,"Training_results"=b,"Testing_results"=c)
  return(mylist)
}

