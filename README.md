README.Rmd
================
André
20/08/2020

# niradm-package: Analysis and graphics and near infrared spectra

## Installation and loading

  - install the latest version from
    [GitHub](https://github.com/admedeiros/niradm-package) as follow:

<!-- end list -->

``` r
#Install
if(!require(devtools)) install.packages("devtools")
```

    ## Loading required package: devtools

    ## Loading required package: usethis

``` r
devtools::install_github("admedeiros/niradm-package")
```

    ## Skipping install of 'niradm' from a github remote, the SHA1 (b6b3e51f) has not changed since last install.
    ##   Use `force = TRUE` to force installation

``` r
#install.packages("pkgload")
#install.packages("processx")
#install.packages('ps')
#install.packages("ellipsis")
#Load package
library(niradm)
```

## Examples

``` r
library(niradm)
pca(nir_seed,1,2)
```

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->
