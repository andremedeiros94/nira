#' @title Applying standard normal variate
#' @description Function for data pre-treatment.
#' @param df data frame with the last column corresponding to the class or group being used.
#' @usage snv(df)
#' @import prospectr
#' @import ggpubr
#' @export
#' 
snv_df<-function(df){
  if (! is.data.frame (df)) {stop ("must be a dataframe")}
  names(df)[names(df) == rev(names(df))[1]] <- 'class'
  df1<-as.data.frame(df[,-ncol(df)])
  df1<- standardNormalVariate(df1)
  df1<-as.data.frame(df1)
  df1$class<-as.factor(df$class)
  df<-df1
  return(as.data.frame(df))
}

