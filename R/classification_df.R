#' @title classification_df
#' @description funcao para desenvolver modelos de classificacao
#' @usage classification_df(df)
#' @param df data frame com a ultima coluna com a classe correspondente
#' @param splitting proporcao da divisao do banco de dados para o treinamento e teste
#' @param algorithm algoritmo para criacao de modelos default plsda
#' @param method_cv The resampling method: "boot", "boot632", "optimism_boot", "boot_all", "cv", "repeatedcv", "LOOCV", "LGOCV"
#' @param number_cv Either the number of folds or number of resampling iterations
#' @param repeat_cv For repeated k-fold cross-validation only: the number of complete sets of folds to compute
#' @param tL tuneLength
#' @param metrics 1 para metricas por classe e 2 para metricas medias
#' @param save Salvar modelo
#' @param varimp importancia das variaveis
#' @param plsplot Plotar PLS
#' @import caret 
#' @import e1071
#' @examples
#' data(nir_seed)
#' dados<-classification_df(nir_seed)
#' @export

classification_df<-function(df,
                            splitting = 0.7,
                            algorithm="kernelpls",
                            method_cv="repeatedcv",
                            number_cv = 10,
                            repeats_cv = 3, 
                            tL = 10, 
                            metrics=1,
                            save=T, 
                            varimp=T,
                            plsplot=T){
  
          set.seed(7)
          trainIndex <- createDataPartition(df[,length(df)],
                                            p = splitting, 
                                            list = FALSE, 
                                            times = 1)
          
          base_treinamento <- df[trainIndex,]
          base_teste<- df[-trainIndex,]
          
        if (metrics==1){
          set.seed(7)
          fitControl <- trainControl(
            method = method_cv,
            number = number_cv,
            ## repeated ten times
            repeats = repeats_cv)}
        if (metrics==2){
          set.seed(7)
          fitControl <- trainControl(
            method = method_cv,
            number = number_cv,
            repeats = repeats_cv,
            classProbs = TRUE,
            savePredictions='all',
            summaryFunction = multiClassSummary)}
          
          
          model = train(base_treinamento[,-length(df)],
                        base_treinamento[,length(df)],
                        method = algorithm,
                        tuneLength = tL,
                        trControl = fitControl);
          a<-model
          
          if (save==T) save(model, file = "model.RData")
          
          previsoes = predict(model , newdata = base_treinamento[,-length(df)])
          matriz_confusao = table(previsoes, base_treinamento[,length(df)])
          if (metrics==1) results_training<-confusionMatrix(matriz_confusao)
          
          
          if (metrics==2){
          previsoes<-as.data.frame(previsoes)
          data<-as.data.frame(cbind(base_treinamento[, length(base_treinamento)], previsoes))
          names(data)<-c('obs','pred')
          data[,1]<-as.factor(data[,1])
          results_training<-multiClassSummary(data, lev = levels(data$obs)) }
          
          b<-results_training
          
          
          previsoes = predict(model, newdata = base_teste[,-length(df)])
          matriz_confusao = table(previsoes,base_teste[, length(df)])
          if (metrics==1) results_test<-confusionMatrix(matriz_confusao)
          
          if (metrics==2){
          previsoes<-as.data.frame(previsoes)
          data<-as.data.frame(cbind(base_teste[, length(base_teste)], previsoes))
          names(data)<-c('obs','pred')
          data[,1]<-as.factor(data[,1])
          results_test<-multiClassSummary(data, lev = levels(data$obs)) }
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
                   y = "Comp 2")+ theme_light ()+ stat_ellipse(level = 0.90, geom = "polygon", alpha = 0.1, aes(fill = class))+
              scale_color_manual(values=c("green", "violet", "mediumpurple1", "slateblue1", "purple", "purple3",
                                                       "turquoise2", "skyblue", "steelblue", "blue2", "navyblue",
                                                       "orange", "tomato", "coral2", "palevioletred", "violetred"))}
          
          
          mylist<-list("Cross-validation"=a,"Training_results"=b,"Testing_results"=c, "Variable importance"=imp, "plsplot"=plot)
          return(mylist)
        }

