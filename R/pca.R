#' @title Autoscaling and center
#' @description Function for data pre-treatment.
#' @param dados data frame with the last column corresponding to the class or group being used.
#' @param axes a numeric vector of length 2 specifying the dimensions to be plotted.
#' @usage scale_center(dados)
#' @import factoextra
#' @import FactoMineR
#' @examples
#' data(nir_seed)
#' dados<-scale_center(nir_seed)
#' a<-vizplotmean(nir_seed)
#' b<-vizplotmean(dados)
#' library(ggpubr)
#' ggarrange(a, b,
#' labels = c("A", "B"),
#' ncol = 2, nrow = 1)
#' @export


pca<-function(dados,compx,compy) {
dados_pca <- PCA(dados[,-ncol(dados)], graph = FALSE)
fviz_eig(dados_pca)
get_eig(dados_pca)

names(dados)[names(dados) == rev(names(dados))[1]] <- 'class' 

a<-fviz_pca_ind(dados_pca, 
                  axes = c(compx,compy),#eixos #axes.linetype = "blank"
                  geom.ind = c('point'),
                  fill.ind = dados$class,
                  col.ind = dados$class, # color by groups
                  palette = c("green", "violet", "mediumpurple1", "slateblue1", "purple", "purple3",
                              "turquoise2", "skyblue", "steelblue", "blue2", "navyblue",
                              "orange", "tomato", "coral2", "palevioletred", "violetred"),
                  addEllipses = T, ellipse.type = "confidence", 
                  legend.title = "Class",
                  repel=T
)+ theme_minimal()  +  theme(panel.grid = element_blank())+ scale_shape_manual(values=seq(0,16))

b<-fviz_pca_var(dados_pca,
                axes=c(compx,compy),
                col.var = "black",
                labelsize = 3,
                alpha.var=0.2,
                repel=T
)+ theme_minimal()

ggarrange(a, b,
          labels = c("A", "B"),
          ncol = 2, nrow = 1)
}


