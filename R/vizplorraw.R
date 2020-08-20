#' @title Visualization of mean spectra per class
#' @description Function to create graphics with NIR spectra
#' @param dados data frame with the last column corresponding to the class or group being used.
#' @details Call files with check.name = T. The name of the spectrum variables must be numeric.
#' @usage vizplotraw(dados)
#' @import dplyr 
#' @import reshape2 
#' @import ggplot2
#' @examples
#' data(nir_seed)
#' vizplotraw(nir_seed)
#' @export
vizplotraw<-function(dados){
  names(dados)[names(dados) == rev(names(dados))[1]] <- 'class'
  dados$class<-as.factor(dados$class)
  dados1<-melt(dados,id= "class")
  dados1<-  mutate(dados1, ordem = rep(seq(1,nrow(dados),1), nlevels(dados$class)*((ncol(dados)-1)/nlevels(dados$class))))
  dados1$variable<-as.numeric(as.character(dados1$variable))
  
  ggplot(data=dados1,
         aes(x=variable, y=value, group=ordem, colour=class)) + theme_classic()+
    geom_line()+scale_x_continuous(name ="Spectral Wavenumber(nm)", minor_breaks=2, n.breaks = 4)+
    scale_color_manual(name="Classes",values=c("green", "violet", "mediumpurple1", "slateblue1", "purple", "purple3",
                                                "turquoise2", "skyblue", "steelblue", "blue2", "navyblue",
                                                "orange", "tomato", "coral2", "palevioletred", "violetred"))
}
