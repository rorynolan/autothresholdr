autothresholdr
================

An R package for thresholding images.

[![Travis-CI Build Status](https://travis-ci.org/rorynolan/autothresholdr.svg?branch=master)](https://travis-ci.org/rorynolan/autothresholdr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rorynolan/autothresholdr?branch=master&svg=true)](https://ci.appveyor.com/project/rorynolan/autothresholdr) [![codecov](https://codecov.io/gh/rorynolan/autothresholdr/branch/master/graph/badge.svg)](https://codecov.io/gh/rorynolan/autothresholdr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/autothresholdr)](https://cran.r-project.org/package=autothresholdr) ![RStudio CRAN downloads](http://cranlogs.r-pkg.org/badges/grand-total/autothresholdr) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

Installation
------------

### Linux

1.  On **Ubuntu** (similarly for other debian **linux**), you need to do:

        sudo apt-get update
        sudo apt-get install libssl-dev libtiff5-dev libfftw3-dev 
        sudo apt-get install libcurl4-openssl-dev libxml2-dev 

2.  In R, run

``` r
install.packages("autothresholdr")
```

### Windows

1.  Go to <https://cran.r-project.org/bin/windows/Rtools/> and install the latest version of Rtools.

2.  In R, run

``` r
install.packages("autothresholdr")
```

### Mac

In R, run

``` r
install.packages("autothresholdr")
```

Installing the development version
----------------------------------

The release version is recommended (and installed with `install.packages("autothresholdr")` as above), but to install the development version, in R enter

``` r
devtools::install_github("rorynolan/autothresholdr")
```

Thresholding Images
===================

Let's load `autothresholdr` and some friends.

``` r
library(autothresholdr)
library(magrittr)
library(graphics)
```

We'll be using the image that comes with the package:

``` r
img <- system.file("extdata", "fiji_eg.tif", package = "autothresholdr") %>%
  tiff::readTIFF(as.is = TRUE)
image(img)
```

![](README_files/figure-markdown_github-ascii_identifiers/the%20image-1.png)

It's a bit of a cell, the black part is where the cell is not. The threshold is supposed to tell us what is *dark* (not cell) and what is *bright* (cell). By playing around, we see that something like 20 might (for some purposes) be a good value.

``` r
image(img >= 20)
```

![](README_files/figure-markdown_github-ascii_identifiers/guess%20twenty-1.png)

But what if we have many images and we don't want to *play around*, we want a method of calculating the threshold automatically. <http://imagej.net/Auto_Threshold> gives many such methods and they are provided to you in R via this package. Go to that webpage for a nice comparison of the methods.

The function `auto_thresh` finds the threshold, `auto_thresh_mask` gets the mask (an array with a `TRUE` for elements exceeding the threshold and `FALSE` elsewhere) and `auto_thresh_apply_mask` applies the mask to the original image by setting the elements that don't exceed the threshold to `NA`.

Let's see each with Huang thresholding. i

``` r
auto_thresh(img, "h")
```

    #> [1] 23
    #> attr(,"ignore_black")
    #> [1] FALSE
    #> attr(,"ignore_white")
    #> [1] FALSE
    #> attr(,"ignore_na")
    #> [1] FALSE
    #> attr(,"autothresh_method")
    #> [1] "Huang"
    #> attr(,"class")
    #> [1] "th"      "integer"

``` r
auto_thresh_mask(img, "h") %>% image()
```

![](README_files/figure-markdown_github-ascii_identifiers/thresh%20mask%20apply-1.png)

``` r
auto_thresh_apply_mask(img, "h") %>% image()
```

![](README_files/figure-markdown_github-ascii_identifiers/thresh%20mask%20apply-2.png)

In this last image, the `NA` pixels are white.
