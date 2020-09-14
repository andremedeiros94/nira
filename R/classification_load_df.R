#' @title load_classifier_df
#' @description function to load and apply classifier created with the classification_df function
#' @param df data frame with the last column corresponding to the class or group being used.
#' @param model classifier model name.
#' @usage load_classifier_df(df, model="model.RData")
#' @import caret
#' @import e1071
#' @export

load_classifier_df<-function(df,model="model.RData"){
  
  load(model)
  
  previsoes = predict(model, newdata = df[,-length(df)])
  matriz_confusao = table(previsoes, df[,length(df)])
  results<-confusionMatrix(matriz_confusao)
  return(results)
}

