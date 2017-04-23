autothresholdr
================

An R package for thresholding images.

[![Travis-CI Build Status](https://travis-ci.org/rorynolan/autothresholdr.svg?branch=master)](https://travis-ci.org/rorynolan/autothresholdr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rorynolan/autothresholdr?branch=master&svg=true)](https://ci.appveyor.com/project/rorynolan/autothresholdr) [![codecov](https://codecov.io/gh/rorynolan/autothresholdr/branch/master/graph/badge.svg)](https://codecov.io/gh/rorynolan/autothresholdr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/autothresholdr)](https://cran.r-project.org/package=autothresholdr) ![RStudio CRAN downloads](http://cranlogs.r-pkg.org/badges/grand-total/autothresholdr) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

Installation
------------

### Everyone except Mac OS X

Install the latest [JDK](http://www.oracle.com/technetwork/java/javase/downloads/index.html).

### Mac OS X

Mac OS X comes with a legacy Apple Java 6. Update your Java installation to a newer version provided by Oracle.

1.  Install [Oracle JDK](http://www.oracle.com/technetwork/java/javase/downloads/index.html).

2.  Update R Java configuration by executing from the command line (you might have to run it as a super user by prepending `sudo` depending on your installation).

        R CMD javareconf

3.  Re-install *rJava* from sources in order to properly link to the non-system Java installation.

    ``` r
    install.packages("rJava", type="source")
    ```

Then, to make everything work with Rstudio, run

    sudo ln -f -s $(/usr/libexec/java_home)/jre/lib/server/libjvm.dylib /usr/local/lib

(taken from <http://stackoverflow.com/questions/30738974/rjava-load-error-in-rstudio-r-after-upgrading-to-osx-yosemite>).

You can verify your configuration by running the following commands. This should return the Java version string corresponding to the one downloaded and installed in step 1.

``` r
library(rJava)
.jinit()
.jcall("java/lang/System", "S", "getProperty", "java.runtime.version")
## [1] "1.8.0_112-b16" 
```

### Everyone!

In R, run

``` r
source("https://bioconductor.org/biocLite.R")
biocLite("EBImage")
install.packages("autothresholdr")
```

and you're done!

Thresholding Images
===================

Let's load `autothresholdr` and some friends.

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

### Use with BiocParallel

Each R process needs a separate JVM instance. For this, load the package in the parallelized function, e.g.,

``` r
bplapply (files, function(f) {
  library(autothresholdr)
  ...
}, BPPARAM = MulticoreParam(...))
```

Thanks to @aoles for his help with this readme. Check out his great work on images in R at his repo <http://github.com/aoles>.
