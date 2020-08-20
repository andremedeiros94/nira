#' @title Visualization of raw spectra
#' @description Function to create graphics with NIR spectra
#' @param dados data frame with the last column corresponding to the class or group being used.
#' @details Call files with check.name = T. The name of the spectrum variables must be numeric.
#' @usage vizplotmean(dados)
#' @import dplyr 
#' @import reshape2 
#' @import ggplot2
#' @examples
#' data(nir_seed)
#' vizplotmean(nir_seed)
#' @export
vizplotmean<-function(dados){
  names(dados)[names(dados) == rev(names(dados))[1]] <- 'class' #nomeando a última variável como class
  dados$class<-as.factor(dados$class) #Transformando em fator
  
  dados1<-melt(dados,id= "class") #Mudando formato
  dados1 <- dcast(dados1, class ~ variable, mean) #Extraindo médias das classes
  dados1<-melt(dados1,id= "class")#Mudando formato
  #inserindo a coluna ordem
  dados1<-  mutate(dados1, 
                   ordem = rep(seq(1,nlevels(dados$class),1), #sequenciando de acordo com o número de individuos, nesse caso como são as médias do grupo temo 6 individuos.
                               #número de vezes que essa sequência é repetida  : 6 x ((3112-1)/6)
                               nlevels(dados$class)*((ncol(dados)-1)/nlevels(dados$class))))
  dados1$variable<-as.numeric(as.character(dados1$variable))
  
  ggplot(data=dados1,
         aes(x=variable, y=value, group=ordem, colour=class)) + theme_classic()+
    geom_line()+scale_x_continuous(name ="Spectral Wavenumber", minor_breaks=2, n.breaks = 6)+
    scale_color_manual(name="Class",values=c("green", "violet", "mediumpurple1", "slateblue1", "purple", "purple3",
                                                "turquoise2", "skyblue", "steelblue", "blue2", "navyblue",
                                                "orange", "tomato", "coral2", "palevioletred", "violetred"))
}
