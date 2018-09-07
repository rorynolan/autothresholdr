
<!-- index.md is generated from index.Rmd. Please edit that file -->

# autothresholdr <img src="man/figures/logo.png" align="right" height=140/>

`autothresholdr` provides algorithms for automatically finding
appropriate thresholds for numerical data, with special functions for
thresholding images. It does this by porting *ImageJ* “Auto Threshold”
plugin functionality to R.

The github repo of `autothresholdr` is at
<https://github.com/rorynolan/autothresholdr>.

## Installation

You can install the release version of `autothresholdr` from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("autothresholdr")
```

You can install the development version of `autothresholdr` from
[GitHub](https://github.com/rorynolan/autothresholdr/) with:

``` r
devtools::install_github("rorynolan/autothresholdr")
```

## How to use the package

The following articles contain all you need to get going:

  - [Finding
    Thresholds](https://rorynolan.github.io/autothresholdr/articles/finding-thresholds.html)
    demonstrates how to find thresholds for arbitrary non-negative
    integer data.
  - [Thresholding
    Images](https://rorynolan.github.io/autothresholdr/articles/thresholding-images.html)
    shows how to threshold single-frame, grayscale images.
  - [Thresholding Image
    Stacks](https://rorynolan.github.io/autothresholdr/articles/thresholding-image-stacks.html)
    shows a couple of approaches for thresholding multi-frame, grayscale
    images.
