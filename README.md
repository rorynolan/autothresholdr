autothresholdr
================

An R package for thresholding images.

[![Travis-CI Build Status](https://travis-ci.org/rorynolan/autothresholdr.svg?branch=master)](https://travis-ci.org/rorynolan/autothresholdr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rorynolan/autothresholdr?branch=master&svg=true)](https://ci.appveyor.com/project/rorynolan/autothresholdr) [![Coverage Status](https://img.shields.io/codecov/c/github/rorynolan/autothresholdr/master.svg)](https://codecov.io/github/rorynolan/autothresholdr?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/autothresholdr)](https://cran.r-project.org/package=autothresholdr)

Installation
------------

On **mac**, you need to go to <https://support.apple.com/kb/dl1572?locale=en_US> and download and install Java 6. On Linux and Windows, you'll also need to have Java jdk installed, so have a google of "install java jdk" for whichever operating system you have and follow the instructions to install it.

Then you need to install the R package `rJava`.

``` r
install.packages("rJava")
```

If this doesn't work, there are plenty of posts on how to troubleshoot installation of `rJava`, bt you'll need to get this done before you can go on. I've previously encountered insurmountable problems while trying to install rJava on 32-bit systems.

Having installed `rJava`, run

``` r
source("https://bioconductor.org/biocLite.R")
biocLite("EBImage")
install.packages("devtools")
devtools::install_github("rorynolan/autothresholdr")
```

and you're done!

Thresholding Images
===================

Let's load it and some friends.

``` r
library(autothresholdr)
library(EBImage)
library(magrittr)
```

We'll be using the image that comes with the package:

``` r
img <- imageData(readImage(system.file("extdata", "eg.tif", 
                                       package = "autothresholdr"), 
                           as.is = TRUE))
display(normalize(img), method = "r")
```

![](README_files/figure-markdown_github/the%20image-1.png)

It's a bit of a cell, the black part is where the cell is not. The threshold is supposed to tell us what is *dark* (not cell) and what is *bright* (cell). By playing around, we see that something like 4 is a good value.

``` r
display(img > 4, method = "r")
```

![](README_files/figure-markdown_github/guess%20four-1.png)

But what if we have many images and we don't want to *play around*, we want a method of calculating the threshold automatically. <http://imagej.net/Auto_Threshold> gives many such methods and they are provided to you in R via this package. Go to that webpage for a nice comparison of the methods.

The function `auto_thresh` finds the threshold, `auto_thresh_mask` gets the mask (an array with a `TRUE` for elements exceeding the threshold and `FALSE` elsewhere) and `auto_thresh_apply_mask` applies the mask to the original image by setting the elements that don't exceed the threshold to `NA`.

Let's see each with Huang thresholding.

``` r
auto_thresh(img, "h")
```

    #> [1] 5

``` r
auto_thresh_mask(img, "h") %>% display(method = "r")
```

![](README_files/figure-markdown_github/thresh%20mask%20apply-1.png)

``` r
auto_thresh_apply_mask(img, "h") %>% normalize %>%  display(method = "r")
```

![](README_files/figure-markdown_github/thresh%20mask%20apply-2.png)

In this last image, the `NA` pixels are greyed.
