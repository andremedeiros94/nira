#' @title  msc_df
#' @description funcao para pre-processamento dos espectros com o Multiplicative Scatter Correction
#' @param dados data frame with the last column corresponding to the class or group being used.
#' @usage msc_df()
#' @export
#' 

msc_df <- function(df, reference = NULL) {
  if (! is.data.frame (df)) {stop ("deve ser um data.frame")}
  X <- Filter(is.numeric, df) 
  X<-as.matrix(X)
  y <- as.list(Filter(is.character, df))
  if (is.null(reference)) reference <- colMeans(X)
  Z <- cbind(1, reference)
  
  B <- t(solve(crossprod(Z), t(X %*% Z)))
  res <- (X - B[,1]) / B[,2]
  attr(res, "reference") <- reference
  class(res) <- c("msc", "matrix")
  
  X<-as.data.frame(res)
  
  if(length(y) == 0){df<-X}
  if(length(y) > 0){df<-cbind(X,y)}
  
  return(df)
}