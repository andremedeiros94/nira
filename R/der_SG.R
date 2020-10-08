#' @title der_SG Applying derivatives with smoothing
#' @description funcao para pre-processamento com a aplicacao de derivadas com a suavizacao de Savitzky-Golay 
#' @param df data frame 
#' @param m the differentiation order.
#' @param p the polynomial order.
#' @param w a window size (must be odd).
#' @usage der_SG( )
#' @import prospectr
#' @import ggpubr
#' @examples
#' data(nir_seed)
#' a<-plotmean_df(nir_seed)
#' 
#' #Applying 1st derivative with Savitzky-Golay smoothing
#' df<-der_SG(nir_seed,1,2,11)
#' b<-plotmean_df(df)
#' 
#' #Applying 2nd derivative with Savitzky-Golay smoothing
#' df<-der_SG(nir_seed,2,2,11)
#' c<-plotmean_df(df)
#' library(ggpubr)
#' ggarrange(a, b, c, 
#' labels = c("A", "B", "C"),
#' ncol = 2, nrow = 2)
#' @export
#' 
der_SG<-function(df,m=1,p=2,w=11){
if (! is.data.frame (df)) {stop ("must be a dataframe")}

if (! is.numeric(df[,ncol(df)])){names(df)[names(df) == rev(names(df))[1]] <- 'class'
                                df1<-as.data.frame(df[,-ncol(df)])}else{
                                  df1<-as.data.frame(df)}
  
df1<- savitzkyGolay(df1,m,p,w)
df1<-as.data.frame(df1)

if (! is.numeric(df[,ncol(df)])){df1$class<-as.factor(df$class)}

return(as.data.frame(df1))
}
