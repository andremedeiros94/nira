
niradm-package: Basic analysis of near-infrared data
====================================================

> This package uses functions developed from the following packages:
> `pls, prospectr, dplyr, reshape2, ggplot2, ggpubr, factoextra,  FactoMineR`.
> We thank the creators of these useful packages.

> Warning: The package is under development and was made for the
> specific needs of our laboratory.

Installation and loading
------------------------

-   install the latest version from
    [GitHub](https://github.com/admedeiros/niradm-package) as follow:

<!-- -->

    #Install
    if(!require(devtools)) install.packages("devtools")
    if(!require(niradm)) devtools::install_github("admedeiros/niradm-package")

    #Load package
    library(niradm)

Examples
--------

### Spectra Visualization

    # raw spectra
    vizplotraw(nir_seed)

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

    # mean spectra per class
    vizplotmean(nir_seed)

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

### View of the exploratory principal component analysis

    pca(nir_seed,1,2)

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

### Autoscaling and center

    library(ggpubr) #for ggarrange
    data(nir_seed)
    dados<-scale_center(nir_seed)
    a<-vizplotmean(nir_seed)
    b<-vizplotmean(dados)
    ggarrange(a, b,
      labels = c("A", "B"),
      ncol = 2, nrow = 1)

![](README_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

### Applying derivatives with Savitzky-Golay smoothing

    data(nir_seed)
    a<-vizplotmean(nir_seed)

    #Applying 1st derivative with Savitzky-Golay smoothing.
    dados<-der_SG(nir_seed,1,2,11)
    b<-vizplotmean(dados)

    #Applying 2nd derivative with Savitzky-Golay smoothing.
    dados<-der_SG(nir_seed,2,2,11)
    c<-vizplotmean(dados)
    ggarrange(a, b, c, 
    labels = c("A", "B", "C"),
    ncol = 2, nrow = 2,  widths = 15,
      heights = 10)

![](README_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->
