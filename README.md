autothresholdr
================

Installation
------------

First you need to install the R package `rJava`. To do this, you'll need to have Java jdk installed, so have a google of "install java jdk" for whichever operating system you have and follow the instructions to install it. Then run

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
