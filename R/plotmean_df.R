#' @title Visualization of raw spectra
#' @description Function to create graphics with NIR spectra
#' @param df data frame with the last column corresponding to the class or group being used.
#' @details Call files with check.name = T. The name of the spectrum variables must be numeric.
#' @usage plotmean_df(df)
#' @import dplyr 
#' @import reshape2 
#' @import ggplot2
#' @examples
#' data(nir_seed)
#' plotmean_df(nir_seed)
#' @export
plotmean_df<-function(df){
  if (! is.data.frame (df)) {stop ("must be a dataframe")}
  names(df)[names(df) == rev(names(df))[1]] <- 'class' #nomeando a última variável como class
  df$class<-as.factor(df$class) #Transformando em fator
  
  df1<-melt(df,id= "class") #Mudando formato
  df1 <- dcast(df1, class ~ variable, mean) #Extraindo médias das classes
  df1<-melt(df1,id= "class")#Mudando formato
  #inserindo a coluna ordem
  df1<-  mutate(df1, 
                   ordem = rep(seq(1,nlevels(df$class),1), #sequenciando de acordo com o número de individuos, nesse caso como são as médias do grupo temos 6 individuos.
                               #número de vezes que essa sequência é repetida  : 6 x ((3112-1)/6)
                               nlevels(df$class)*((ncol(df)-1)/nlevels(df$class))))
  df1$variable<-as.numeric(as.character(df1$variable))
  
  ggplot(data=df1,
         aes(x=variable, y=value, group=ordem, colour=class)) + theme_classic()+
    geom_line()+scale_x_continuous(name ="Spectral wavelength", minor_breaks=2, n.breaks = 6)+
    scale_color_manual(name="Class",values=c("green", "violet", "mediumpurple1", "slateblue1", "purple", "purple3",
                                                "turquoise2", "skyblue", "steelblue", "blue2", "navyblue",
                                                "orange", "tomato", "coral2", "palevioletred", "violetred"))
  }
  
