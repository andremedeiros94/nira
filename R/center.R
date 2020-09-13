#' @title Center
#' @description Function for data pre-treatment.
#' @param dados data frame with the last column corresponding to the class or group being used.
#' @usage scale_center(dados)
#' @import ggpubr
#' @examples
#' data(nir_seed)
#' dados<-center_df(nir_seed)
#' a<-vizplotmean(nir_seed)
#' b<-vizplotmean(dados)
#' library(ggpubr)
#' ggarrange(a, b,
#' labels = c("A", "B"),
#' ncol = 2, nrow = 1)
#' @export

center_df <- function (df) {
  if (! is.data.frame (df)) {stop ("must be a dataframe")}
  for (i in 1:NCOL(df)){
    if (is.numeric(df[,i])==TRUE){
      df[,i] = df[,i]-mean(df[,i], na.rm = T) 
    }}
  
  return (df) }