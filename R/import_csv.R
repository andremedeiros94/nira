#' @title Import CSV
#' @description Import and merge CSV NIR files
#' @param directory Enter working directory address.
#' @usage import_csv(directory)
#' @import dplyr
#' @import readxl
#' @export
#' 
import_csv<-function(directory=choose.dir()){
  setwd(directory)
  lista<-list.files(pattern="*.csv",full.names=F)
  arquivos <- lapply(lista, function(x) read.csv(x, header=F)) 
  df    <- do.call("cbind", arquivos) 
  elim<-seq(from = 3, to = length(df), by = 2)
  df<-df[,-c(elim)]
  df<-as.data.frame(t(df))
  names(df) <- df[1,]
  df <- df[-1,]
  rownames(df)<-lista
  return(df)
}

