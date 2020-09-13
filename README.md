
![](https://raw.githubusercontent.com/admedeiros/niradm-package/master/logo/logo-02.png)

`niradm`: Near-infrared data analysis
=====================================

Author: M.Sc André Dantas de Medeiros (Universidade Federal de viçosa).
Email:
<a href="mailto:andre.d.medeiros@ufv.br" class="email">andre.d.medeiros@ufv.br</a>

> This package uses functions developed from the following packages:
> `pls, prospectr, dplyr, reshape2, ggplot2, ggpubr, factoextra,  FactoMineR`.
> We thank the creators of these useful packages.

**Warning**:

-   The data structure must be in Dataframe format. Use the following
    command to transform it into a dataframe: `as.data.frame()`.

-   The last column must contain the response variable in `factor`
    or`character` format.

-   The package is under development and was made for the specific needs
    of our laboratory.

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

Main functions:
---------------

`vizplotmean_df()`: Create graphics with the average of the spectra
class.

`vizplotraw_df()`: Create graphics with the raw of the spectra class.

`center_df()`: Center the data on the average.

`autoscaling_df()`: Autoscaling the data using the Z-score
transformation.

`snv_df()`: Standard Normal Variate (SNV) on near-infrared (NIR) data.

`msc_df()`: Multiplicative Scatter Correction (MSC) on near-infrared
(NIR) data.

`der_df()`: Applying derivatives with Savitzky-Golay smoothing..

`pca_df()`: Plots a graph of the principal component analysis.

Examples
--------

### Spectra Visualization

    library(ggpubr) #for ggarrange

    ## Loading required package: ggplot2

    # raw spectra
    a<-plotraw_df(nir_seed)
    # mean spectra per class
    b<-plotmean_df(nir_seed)

    ggarrange(a, b,
      labels = c("Raw spectra", "Mean spectra"),
      ncol = 2, nrow = 1)

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

### View of the exploratory principal component analysis

    pca_df(nir_seed,1,2)

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

### Autoscaling

    data(nir_seed)
    dados<-autoscaling_df(nir_seed)
    a<-plotmean_df(nir_seed)
    b<-plotmean_df(dados)
    ggarrange(a, b,
      labels = c("Raw spectra", "Autoscaling spectra"),
      ncol = 2, nrow = 1)

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

### Applying derivatives with Savitzky-Golay smoothing

    data(nir_seed)
    a<-plotmean_df(nir_seed)

    #Applying 1st derivative with Savitzky-Golay smoothing.
    dados<-der_SG(nir_seed,1,2,11)
    b<-plotmean_df(dados)

    #Applying 2nd derivative with Savitzky-Golay smoothing.
    dados<-der_SG(nir_seed,2,2,11)
    c<-plotmean_df(dados)
    ggarrange(a, b, c, 
    labels = c("Raw spectra", "1st derivative", "2nd derivative"),
    ncol = 3, nrow = 1,  widths = 15,
      heights = 10)

![](README_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->
