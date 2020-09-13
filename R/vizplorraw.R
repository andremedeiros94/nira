#' @title Visualization of mean spectra per class
#' @description Function to create graphics with NIR spectra
#' @param df data frame with the last column corresponding to the class or group being used.
#' @details Call files with check.name = T. The name of the spectrum variables must be numeric.
#' @usage plotraw_df(df)
#' @import dplyr 
#' @import reshape2 
#' @import ggplot2
#' @examples
#' data(nir_seed)
#' plotraw_df(nir_seed)
#' @export
plotraw_df<-function(df){
  if (! is.data.frame (df)) {stop ("must be a dataframe")}
  names(df)[names(df) == rev(names(df))[1]] <- 'class'
  df$class<-as.factor(df$class)
  df1<-melt(df,id= "class")
  df1<-  mutate(df1, ordem = rep(seq(1,nrow(df),1), nlevels(df$class)*((ncol(df)-1)/nlevels(df$class))))
  df1$variable<-as.numeric(as.character(df1$variable))
  
  ggplot(data=df1,
         aes(x=variable, y=value, group=ordem, colour=class)) + theme_classic()+
    geom_line()+scale_x_continuous(name ="Spectral Wavenumber(nm)", minor_breaks=2, n.breaks = 4)+
    scale_color_manual(name="Class",values=c("green", "violet", "mediumpurple1", "slateblue1", "purple", "purple3",
                                                "turquoise2", "skyblue", "steelblue", "blue2", "navyblue",
                                                "orange", "tomato", "coral2", "palevioletred", "violetred"))
}
