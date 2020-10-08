#' @title prediction_df
#' @description funcao para aplicar o classificador em novos dados sem rotulos
#' @param df data frame 
#' @param model nome do modelo que se deseja carregar
#' @usage prediction_df(df, model="model.RData")
#' @import caret
#' @import e1071
#' @export

prediction_df<-function(df,model="model.RData"){
  
  load(model)
  
  previsoes = predict(model, newdata = df)
  df["predicted class"]<-previsoes
  return(df)
}

