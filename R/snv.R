#' @title Applying standard normal variate
#' @description Function for data pre-treatment.
#' @param dados data frame with the last column corresponding to the class or group being used.
#' @usage snv(dados)
#' @import prospectr
#' @import ggpubr
#' @examples
#' @export
#' 
snv<-function(dados){
  names(dados)[names(dados) == rev(names(dados))[1]] <- 'class'
  dados1<-as.data.frame(dados[,-ncol(dados)])
  dados1<- standardNormalVariate(dados1)
  dados1<-as.data.frame(dados1)
  dados1$class<-as.factor(dados$class)
  dados<-dados1
  return(as.data.frame(dados))
}

