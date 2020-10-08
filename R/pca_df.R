#' @title pca_df
#' @description funcao para analise exploratoria de componentes principais
#' @param df data frame 
#' @param compx numero especificando qual o componente sera disposto no eixo x
#' @param compx numero especificando qual o componente sera disposto no eixo y
#' @usage pca_df()
#' @import factoextra
#' @import FactoMineR
#' @import ggpubr
#' @examples
#' data(nir_seed)
#' pca_df(nir_seed)
#' @export

pca_df<-function(df,
                 compx=1,
                 compy=2,
                 color=c("green", "violet", "mediumpurple1", "slateblue1", "purple", "purple3",
                         "turquoise2", "skyblue", "steelblue", "blue2", "navyblue",
                         "orange", "tomato", "coral2", "palevioletred", "violetred")) {
if (! is.data.frame (df)) {stop ("must be a dataframe")}
 
if (! is.numeric(df[,ncol(df)])){
df_pca <- PCA(df[,-ncol(df)], graph = FALSE)
fviz_eig(df_pca)
get_eig(df_pca)

names(df)[names(df) == rev(names(df))[1]] <- 'class' 

a<-fviz_pca_ind(df_pca, 
                  axes = c(compx,compy),#eixos #axes.linetype = "blank"
                  geom.ind = c('point'),
                  fill.ind = df$class,
                  col.ind = df$class, # color by groups
                  palette = c(color),
                  addEllipses = T, ellipse.type = "confidence", 
                  legend.title = "Class",
                  repel=T
)+ theme_minimal()  +  theme(panel.grid = element_blank())+ scale_shape_manual(values=seq(0,16))
}else{
 
  df_pca <- PCA(df, graph = FALSE)
  fviz_eig(df_pca)
  get_eig(df_pca)
  
  a<-fviz_pca_ind(df_pca, 
                  axes = c(compx,compy),#eixos #axes.linetype = "blank"
                  geom.ind = c('point'),
                  pointsize=3,
                  pointshape=19,
                  col.ind = "blue", # color by groups
                  alpha.ind = 0.5,
                  # addEllipses = T, ellipse.type = "confidence", 
                  repel=T)+ theme_minimal()+
    theme(panel.grid = element_blank())}

b<-fviz_pca_var(df_pca,
                geom.var = c("arrow"),
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


