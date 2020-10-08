#' @title Center_df
#' @description funcao para centralizar os dados na media
#' @param dados data frame 
#' @usage scale_center(dados)
#' @import ggpubr
#' @examples
#' data(nir_seed)
#' dados<-center_df(nir_seed)
#' a<-plotmean_df(nir_seed)
#' b<-plotmean_df(dados)
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
