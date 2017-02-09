autothresholdr
================

[![Travis-CI Build Status](https://travis-ci.org/rorynolan/autothresholdr.svg?branch=master)](https://travis-ci.org/rorynolan/autothresholdr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rorynolan/autothresholdr?branch=master&svg=true)](https://ci.appveyor.com/project/rorynolan/autothresholdr)

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
install.packages("devtools")
devtools::install_github("rorynolan/autothresholdr")
```

and you're done!
