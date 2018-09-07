
# autothresholdr <img src="man/figures/logo.png" align="right" height=140/>

An R package for thresholding images.

[![Travis-CI Build
Status](https://travis-ci.org/rorynolan/autothresholdr.svg?branch=master)](https://travis-ci.org/rorynolan/autothresholdr)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/rorynolan/autothresholdr?branch=master&svg=true)](https://ci.appveyor.com/project/rorynolan/autothresholdr)
[![codecov](https://codecov.io/gh/rorynolan/autothresholdr/branch/master/graph/badge.svg)](https://codecov.io/gh/rorynolan/autothresholdr)

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/autothresholdr)](https://cran.r-project.org/package=autothresholdr)
![RStudio CRAN total
downloads](http://cranlogs.r-pkg.org/badges/grand-total/autothresholdr)
[![RStudio CRAN monthly
downloads](http://cranlogs.r-pkg.org/badges/autothresholdr)](http://cran.rstudio.com/web/packages/autothresholdr/index.html)
[![Rdocumentation](http://www.rdocumentation.org/badges/version/autothresholdr)](http://www.rdocumentation.org/packages/autothresholdr)
[![DOI](https://zenodo.org/badge/72632397.svg)](https://zenodo.org/badge/latestdoi/72632397)

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable)

## Installation

### `libtiff`

`autothresholdr` requires you to have the `libtiff` C library installed.
To install `libtiff`:

  - On **Debian Linux**, try `sudo apt-get install libtiff5-dev`, or if
    that fails, try  
    `sudo apt-get install libtiff4-dev`.
  - On **Fedora Linux**, try `sudo yum install libtiff5-dev`, or if that
    doesn’t work, try  
    `sudo yum install libtiff4-dev`.
  - On **Mac**, you need [Homebrew](https://brew.sh/). Then in the
    terminal, run `brew install libtiff`.
  - On **Windows**, go to
    <https://cran.r-project.org/bin/windows/Rtools/> and install the
    latest version of Rtools. If you have 32-bit windows, you also need
    to install `libtiff` from
    <http://gnuwin32.sourceforge.net/packages/tiff.htm>.

### Installing the release version

You can install `autothresholdr` from CRAN (recommended) with:

``` r
install.packages("autothresholdr")
```

### Installing the development version

You can install the development version from GitHub with:

``` r
if (!require(devtools)) install.packages("devtools")
devtools::install_github("rorynolan/autothresholdr")
```

## Vignette

To learn how to use the package, consult the
[vignette](https://cran.r-project.org/web/packages/autothresholdr/vignettes/autothresholdr.html).

## Contribution

Contributions to this package are welcome. The preferred method of
contribution is through a github pull request. Feel free to contact me
by creating an issue. Please note that this project is released with a
[Contributor Code of Conduct](CONDUCT.md). By participating in this
project you agree to abide by its terms.
