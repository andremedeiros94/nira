#' @title Autoscaling and center
#' @description Function for data pre-treatment.
#' @param dados data frame with the last column corresponding to the class or group being used.
#' @usage scale_center(dados)
#' @import ggpubr
#' @examples
#' data(nir_seed)
#' dados<-scale_center(nir_seed)
#' a<-vizplotmean(nir_seed)
#' b<-vizplotmean(dados)
#' library(ggpubr)
#' ggarrange(a, b,
#' labels = c("A", "B"),
#' ncol = 2, nrow = 1)
#' @export

scale_center<-function(dados){
  dados[,-ncol(dados)]<-scale(dados[,-ncol(dados)])
    return(as.data.frame(dados))
}


