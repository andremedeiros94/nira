#' @title Autoscaling 
#' @description Function for data pre-treatment.
#' @param df data frame with the last column corresponding to the class or group being used.
#' @usage autoscaling(df)
#' @import ggpubr
#' @examples
#' data(nir_seed)
#' df<-autoscaling_df(nir_seed)
#' a<-plotmean_df(nir_seed)
#' b<-plotmean_df(df)
#' library(ggpubr)
#' ggarrange(a, b,
#' labels = c("A", "B"),
#' ncol = 2, nrow = 1)
#' @export

autoscaling_df<-function(df){
  if (! is.data.frame (df)) {stop ("must be a dataframe")}
  df[,-ncol(df)]<-scale(df[,-ncol(df)])
    return(as.data.frame(df))
}


