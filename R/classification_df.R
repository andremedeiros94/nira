#' @title classification_df
#' @description Function to develop classification models
#' @param df data frame with the last column corresponding to the class or group being used.
#' @param splitting Establishes the proportion and creates divisions balanced the training data and test.
#' @param algorithm Algorithm that will be used to create the models.
#' @param method_cv The resampling method: "boot", "boot632", "optimism_boot", "boot_all", "cv", "repeatedcv", "LOOCV", "LGOCV"
#' @param number_cv Either the number of folds or number of resampling iterations
#' @param repeat_cv For repeated k-fold cross-validation only: the number of complete sets of folds to compute
#' @param tL tuneLength
#' @param save Salvar modelo
#' @param plsplot Plotar PLS
#' @usage classification_df(df)
#' @import caret
#' @import e1071
#' @examples
#' data(nir_seed)
#' dados<-classification_df(nir_seed)
#' @export

classification_df<-function(df,
                            splitting=0.7,
                            algorithm="kernelpls",
                            method_cv="repeatedcv",
                            number_cv = 10,
                            repeats_cv=3, 
                            tL = 10, 
                            save=T, 
                            varimp=T,
                            plsplot=T){
  
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
                tuneLength = tL,
                trControl = fitControl);
  a<-model
  
  if (save==T) save(model, file = "model.RData")
  
  previsoes = predict(model , newdata = base_treinamento[,-length(df)])
  matriz_confusao = table(previsoes, base_treinamento[,length(df)])
  results_training<-confusionMatrix(matriz_confusao)
  b<-results_training
  
  previsoes = predict(model, newdata = base_teste[,-length(df)])
  matriz_confusao = table(previsoes,base_teste[, length(df)])
  results_test<-confusionMatrix(matriz_confusao)
  c<-results_test
  
  if (varimp==T) imp<-varImp(model, scale=TRUE)
  
  if (plsplot==T){
    Scores <- a$finalModel$scores
    Scores<-as.matrix.data.frame(Scores)
    Scores<-as.data.frame(Scores)
    
    class<-base_treinamento[,length(base_treinamento)]
    comp<-cbind(Scores,class)
    
    plot<-ggplot(comp, aes(x=V1,y=V2, color= class, shape = class)) + geom_point(size=3, alpha = 0.5)+
      labs(x = "Comp 1",
           y = "Comp 2")+ theme_light ()+ stat_ellipse(level = 0.90, geom = "polygon", alpha = 0.1, aes(fill = class))}
  
  
  mylist<-list("Cross-validation"=a,"Training_results"=b,"Testing_results"=c, "Variable importance"=imp, "plsplot"=plot)
  return(mylist)
}

