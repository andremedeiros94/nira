#' @title Applying derivatives with Savitzky-Golay smoothing
#' @description Function for data pre-treatment.
#' @param dados data frame with the last column corresponding to the class or group being used.
#' @param m the differentiation order.
#' @param p the polynomial order.
#' @param w a window size (must be odd).
#' @usage der_SG(dados)
#' @import prospectr
#' @import ggpubr
#' @examples
#' data(nir_seed)
#' a<-vizplotmean(nir_seed)
#' 
#' #Applying 1st derivative with Savitzky-Golay smoothing.
#' dados<-der_SG(nir_seed,1,2,11)
#' b<-vizplotmean(dados)
#' 
#' #Applying 2nd derivative with Savitzky-Golay smoothing.
#' dados<-der_SG(nir_seed,2,2,11)
#' c<-vizplotmean(dados)
#' library(ggpubr)
#' ggarrange(a, b, c, 
#' labels = c("A", "B", "C"),
#' ncol = 2, nrow = 2)
#' @export
#' 
der_SG<-function(dados,m=1,p=2,w=11){
dados1<-as.data.frame(dados[,-ncol(dados)])
dados1<- savitzkyGolay(dados1,m,p,w)
dados1<-as.data.frame(dados1)
dados1$class<-as.factor(rev(names(dados))[1])
dados<-dados1
return(as.data.frame(dados))
}

