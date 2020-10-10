#' @title SNV
#' @description funcao para pre-processamento com Standard Normal Variate
#' @param df data frame 
#' @usage snv(df)
#' @export
#' 
snv_df <- function (df) {
  if (! is.data.frame (df)) {stop ("deve ser um data.frame")}
  x <- Filter(is.numeric, df) 
  y <- as.list(Filter(is.character, df))
  y1 <- as.list(Filter(is.factor, df))
  x<-t(x)       
  for (i in 1:NCOL(x)){
    x[,i] = (x[,i]-mean(x[,i]))/sd(x[,i]) 
  }
  x<-as.data.frame(t(x))
  if(length(y) == 0 & length(y1) == 0 ){df<-x}
  if(length(y) > 0) {df<-cbind(x,y)}
  if(length(y1) > 0) {df<-cbind(x,y1)}
  
  return (df) }