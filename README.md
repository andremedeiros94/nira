
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
if(!require(niradm)) devtools::install_github("admedeiros/niradm-package")
```

    ## Loading required package: niradm

``` r
#Load package
library(niradm)
```

## Examples

### Spectra Visualization

``` r
# raw spectra
vizplotraw(nir_seed)
```

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

``` r
# mean spectra per class
vizplotmean(nir_seed)
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
library(niradm)
pca(nir_seed,1,2)
```

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->
