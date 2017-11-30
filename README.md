autothresholdr
================

An R package for thresholding images.

[![Travis-CI Build Status](https://travis-ci.org/rorynolan/autothresholdr.svg?branch=master)](https://travis-ci.org/rorynolan/autothresholdr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rorynolan/autothresholdr?branch=master&svg=true)](https://ci.appveyor.com/project/rorynolan/autothresholdr) [![codecov](https://codecov.io/gh/rorynolan/autothresholdr/branch/master/graph/badge.svg)](https://codecov.io/gh/rorynolan/autothresholdr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/autothresholdr)](https://cran.r-project.org/package=autothresholdr) ![RStudio CRAN total downloads](http://cranlogs.r-pkg.org/badges/grand-total/autothresholdr) [![RStudio CRAN monthly downloads](http://cranlogs.r-pkg.org/badges/autothresholdr)](http://cran.rstudio.com/web/packages/autothresholdr/index.html) [![Rdocumentation](http://www.rdocumentation.org/badges/version/autothresholdr)](http://www.rdocumentation.org/packages/autothresholdr) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

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

Vignette
--------

To learn how to use the package, consult the [vignette](https://cran.r-project.org/web/packages/autothresholdr/vignettes/autothresholdr.html).

Contribution
------------

Contributions to this package are welcome. The preferred method of contribution is through a github pull request. Feel free to contact me by creating an issue. Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
